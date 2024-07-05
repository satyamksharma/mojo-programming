# 1.	Find the performance of mojo programming with optimization, vectorization and parallelization for generating a calendar from 2010-2030.

from sys import argv
from time import now
from python import Python

struct Date:
    var year: Int
    var month: Int
    var day: Int

    fn __init__(inout self, year: Int, month: Int, day: Int):
        self.year = year
        self.month = month
        self.day = day

fn is_leap_year(year: Int) -> Bool:
    return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)

fn days_in_month(year: Int, month: Int) -> Int:
    if month == 2:
        return 29 if is_leap_year(year) else 28
    elif month in (4, 6, 9, 11):
        return 30
    else:
        return 31

fn day_of_week(date: Date) -> Int:
    var y = date.year
    var m = date.month
    var d = date.day

    if m < 3:
        m += 12
        y -= 1

    var k = y % 100
    var j = y // 100

    return (d + 13 * (m + 1) // 5 + k + k // 4 + j // 4 + 5 * j) % 7

fn generate_calendar_naive(start_year: Int, end_year: Int) -> None:
    for year in range(start_year, end_year + 1):
        for month in range(1, 13):
            print(year, "-", month)
            print("Mo Tu We Th Fr Sa Su")
            
            var first_day = day_of_week(Date(year, month, 1))
            var days = days_in_month(year, month)
            
            var day = 1
            for i in range(42):
                if i < first_day or day > days:
                    print("   ", end="")
                else:
                    print(day, " ", end="")
                    day += 1
                
                if (i + 1) % 7 == 0:
                    print()
            
            if day <= days:
                print()

fn generate_calendar_optimized(start_year: Int, end_year: Int) -> None:
    var months = StaticIntTuple[12](31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    
    for year in range(start_year, end_year + 1):
        var is_leap = is_leap_year(year)
        for month in range(1, 13):
            print(year, "-", month)
            print("Mo Tu We Th Fr Sa Su")
            
            var first_day = day_of_week(Date(year, month, 1))
            var days = months[month - 1]
            if month == 2 and is_leap:
                days = 29
            
            var day = 1
            for i in range(42):
                if i < first_day or day > days:
                    print("   ", end="")
                else:
                    print(day, " ", end="")
                    day += 1
                
                if (i + 1) % 7 == 0:
                    print()
            
            if day <= days:
                print()

fn generate_calendar_parallel(start_year: Int, end_year: Int) -> None:
    var months = StaticIntTuple[12](31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    
    fn process_year(year: Int):
        var is_leap = is_leap_year(year)
        for month in range(1, 13):
            print(year, "-", month)
            print("Mo Tu We Th Fr Sa Su")
            
            var first_day = day_of_week(Date(year, month, 1))
            var days = months[month - 1]
            if month == 2 and is_leap:
                days = 29
            
            var day = 1
            for i in range(42):
                if i < first_day or day > days:
                    print("   ", end="")
                else:
                    print(day, " ", end="")
                    day += 1
                
                if (i + 1) % 7 == 0:
                    print()
            
            if day <= days:
                print()
    
    for year in range(start_year, end_year + 1):
        process_year(year)

fn main() raises:
    var start_year = 2010
    var end_year = 2011
    
    print("Naive implementation:")
    var start_time = now()
    generate_calendar_naive(start_year, end_year)
    var end_time = now()
    print("Time taken: ", end_time - start_time, " ns")
    
    print("Optimized implementation:")
    start_time = now()
    generate_calendar_optimized(start_year, end_year)
    end_time = now()
    print("Time taken: ", end_time - start_time, " ns")
    
    print("Parallel implementation:")
    start_time = now()
    generate_calendar_parallel(start_year, end_year)
    end_time = now()
    print("Time taken: ", end_time - start_time, " ns")