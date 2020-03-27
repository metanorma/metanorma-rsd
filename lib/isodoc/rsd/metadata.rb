require "isodoc"

module IsoDoc
  module Rsd

    class Metadata < IsoDoc::Generic::Metadata
      def configuration
        Metanorma::Rsd.configuration
      end

      def security(isoxml, _out)
        security = isoxml.at(ns("//bibdata/ext/security")) || return
        set(:security, security.text)
      end

      def version(isoxml, _out)
        super
        revdate = get[:revdate]
        set(:revdate_monthyear, monthyr(revdate))
      end

      MONTHS = {
        "01": "January",
        "02": "February",
        "03": "March",
        "04": "April",
        "05": "May",
        "06": "June",
        "07": "July",
        "08": "August",
        "09": "September",
        "10": "October",
        "11": "November",
        "12": "December",
      }.freeze

      def monthyr(isodate)
        m = /(?<yr>\d\d\d\d)-(?<mo>\d\d)/.match isodate
        return isodate unless m && m[:yr] && m[:mo]
        return "#{MONTHS[m[:mo].to_sym]} #{m[:yr]}"
      end
    end
  end
end
