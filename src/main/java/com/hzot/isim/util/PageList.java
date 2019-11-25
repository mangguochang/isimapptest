package com.hzot.isim.util;

public class PageList {

    public boolean first;
    public boolean last;
    public Integer number;
    public Integer numberOfElements;
    public Integer size;
    public String sort;
    public Integer totalElements;
    public Integer totalPages;
    public Object content;

    public Object getContent() {
        return content;
    }

    public void setContent(Object content) {
        this.content = content;
    }

    public boolean isFirst() {
        return first;
    }

    public boolean isLast() {
        return last;
    }

    public Integer getNumber() {
        return number;
    }

    public Integer getNumberOfElements() {
        return numberOfElements;
    }

    public Integer getSize() {
        return size;
    }

    public String getSort() {
        return sort;
    }

    public Integer getTotalElements() {
        return totalElements;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setFirst(boolean first) {
        this.first = first;
    }

    public void setLast(boolean last) {
        this.last = last;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public void setNumberOfElements(Integer numberOfElements) {
        this.numberOfElements = numberOfElements;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public void setTotalElements(Integer totalElements) {
        this.totalElements = totalElements;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }
}
