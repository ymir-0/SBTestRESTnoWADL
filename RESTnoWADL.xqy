xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace exam="http://www.example.org";
(:: import schema at "RESTnoWADL.xsd" ::)

declare variable $request as element() (:: schema-element(exam:request) ::) external;

declare function local:concatOneParameter($parameter as element() (:: schema-element(exam:parameter) ::)) as xs:string {
    fn:concat(
      encode-for-uri($parameter/exam:paramName)
      ,"="
      ,encode-for-uri($parameter/exam:paramValue)
    )
};

declare function local:concatAllParameters($parameters as element() (:: schema-element(exam:parameters) ::)) as xs:string {
    fn:string-join(
      for $parameter in $parameters/exam:parameter return local:concatOneParameter($parameter)
      ,"&amp;"
    )
};

declare function local:createRawURL($request as element() (:: schema-element(exam:request) ::)) as xs:string {
    fn:concat(
      $request/exam:URI
      ,"/"
      ,encode-for-uri($request/exam:member)
      ,"?"
      ,local:concatAllParameters($request/exam:parameters)
    )
};

local:createRawURL($request)
