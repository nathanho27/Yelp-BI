import os
import time
import requests
import pandas as pd
import re
from pathlib import Path
from dotenv import load_dotenv
import argparse

# load api key
load_dotenv()
apiKey = os.getenv("YelpAPIKey")
if not apiKey:
    raise ValueError("no yelp api key found in .env")

# base setup
headers = {"Authorization": f"Bearer {apiKey}"}
baseURL = "https://api.yelp.com/v3"

# save folder
savePath = Path("data/raw")
savePath.mkdir(parents=True, exist_ok=True)

# api call wrapper
def getYelp(url, params=None):
    try:
        response = requests.get(url, headers=headers, params=params, timeout=18)
        return response.json() if response.status_code == 200 else None
    except:
        return None

# get extra business details
def getBusinessDetails(businessID):
    data = getYelp(f"{baseURL}/businesses/{businessID}")
    if not data:
        return {}

    categories = data.get("categories") or []
    location = data.get("location") or {}

    hours = None
    if data.get("hours") and data["hours"][0].get("open"):
        hours = ";".join([f"{h['day']}:{h['start']}-{h['end']}" for h in data["hours"][0]["open"]])

    return {
        "price": data.get("price"),
        "phone": data.get("phone"),
        "display_phone": data.get("display_phone"),
        "biz_url": data.get("url"),
        "address": ", ".join(location.get("display_address", [])) if location.get("display_address") else None,
        "categories_alias": ", ".join([c["alias"] for c in categories]) if categories else None,
        "categories_title": ", ".join([c["title"] for c in categories]) if categories else None,
        "hours": hours,
        "photos": ", ".join(data.get("photos", [])) if data.get("photos") else None,
        "is_closed": data.get("is_closed"),
    }

# file cleaner
def makeFileName(location, category):
    name = location.lower().replace(" ", "_").replace(",", "_")
    if category:
        name += "_" + category.lower()
    return re.sub(r"[^a-z0-9_]", "", name)[:45]

# main fetch
def fetchYelpData(location, category, limit, maxBusinesses):
    businessList = []
    count = 0
    offset = 0

    while count < maxBusinesses:
        params = {"location": location, "limit": limit, "offset": offset}
        if category:
            params["categories"] = category

        data = getYelp(f"{baseURL}/businesses/search", params)
        if not data or "businesses" not in data:
            break

        for biz in data["businesses"]:
            businessID = biz["id"]
            bizLocation = biz.get("location", {})
            coordinates = biz.get("coordinates", {})
            extraData = getBusinessDetails(businessID)

            businessList.append({
                "search_location": location,
                "search_category": category,
                "business_id": businessID,
                "name": biz.get("name"),
                "city": bizLocation.get("city"),
                "state": bizLocation.get("state"),
                "postal_code": bizLocation.get("zip_code"),
                "address": extraData.get("address"),
                "latitude": coordinates.get("latitude"),
                "longitude": coordinates.get("longitude"),
                "rating": biz.get("rating"),
                "review_count": biz.get("review_count"),
                "price": extraData.get("price") or biz.get("price"),
                "phone": extraData.get("phone"),
                "display_phone": extraData.get("display_phone"),
                "categories_alias": extraData.get("categories_alias"),
                "categories_title": extraData.get("categories_title"),
                "hours": extraData.get("hours"),
                "photos": extraData.get("photos"),
                "biz_url": extraData.get("biz_url"),
                "is_closed": extraData.get("is_closed"),
            })

            count += 1
            if count >= maxBusinesses:
                break

            time.sleep(0.1)

        offset += limit
        time.sleep(0.3)
        if offset >= 1000:
            break

    fileName = makeFileName(location, category)

    if businessList:
        pd.DataFrame(businessList).to_csv(savePath / f"{fileName}_businesses.csv", index=False)
        print("saved:", len(businessList), "businesses")

# run
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--location", required=True)
    parser.add_argument("--category")
    parser.add_argument("--limit", type=int, default=50)
    parser.add_argument("--maxBusinesses", type=int, default=200)
    args = parser.parse_args()

    fetchYelpData(args.location, args.category, args.limit, args.maxBusinesses)
    print("done")




