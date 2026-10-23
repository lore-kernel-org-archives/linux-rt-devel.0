Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792767401;
	b=BTNWMF/np93SxGdnniA05acw67dqFkbHx/RCymx3B10hQBcpON4XHwRPxXS7YK8C/81j
	 5jXkdt/1evZumKP8Ao4zr+C/TczgrUmztpfy8tRn5jVRVmatuZFdQWTlBfYge6Cz2A+mM
	 ksluvrFZgiyxl3/fECw9NA6petIZOWRVyXmeQsbxmDnbHlnzB/NUsux+FCmHvM1T7AC43
	 GYTTKzdxnlON4tJIeDHfkGkWJmypdEXHDXhZ2+CHAqg8/sjA3601S8iRlNo9bWp2rgGh0
	 JSsxxumh4bOg3fsKmmpzUHDoA039IQKyOjZ4tC4kf1Us6Bob7AbF2CnzaSsZqGqR5Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767401;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=RnrfelN52PjZk0gZd9Y5uXLnWEDVXG4+u2JR5D5ajrc=;
	b=zCfZcAUhc8Y+WpeLyVfkHLs006Sm6HENg2QwcFufclr3XOuEu504mn6v8xF6wRTQXtON
	 LcMVEdFLiK8qXtGQr/+yCLj6Ao9VrMrxW1LRbfa1Z6tuqfnKJKiLb4f1IL+6/VAyEZ5ga
	 CHeZEAozbPnPl4KDGskALnzTGSWbpTX/vqGSR3k7KyPm6S2BcpYflqeJTDUUpEPlTryXr
	 2xXX0aNCg85DMn7pJ6B7c1pyCKc31bUlgQRR4eS4SjfPW/4SxHMcPFlbiH5EcOkwbG8Ae
	 s+2olQ+CemvcoPzPCjZ1forMJzJ5HyNGjOyIIHgzZL0eZuDdHlFQFAzVMA6groVshMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R38CrdCH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A88606A31A
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Oct 2026 14:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A88606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R38CrdCH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792767400; x=1824303400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lr/7iD6zdWq55EL6dy/S4RuswmyqYSu08XkqypPWS+w=;
  b=R38CrdCHPmVlGdOS4rMModfjHS39HRbr7naMHf1MQv7WNDLPttrzjw/W
   EbQ4WZHGacjPBObz8lBhxLoXBBE+/3UWsRRKgaJyV15FPO6mWq1qKr23J
   sMFVC5YVPIksW9oIs+4kN27NNLWLJYpkcHc4SXafMKV/OWVwzJuFsg1KL
   UyokERHq2udvVNWpfs+yoGWdOqBhGqpNJE1LcQ1/758+g6wWesLEHiHWh
   7/oTYk98Z3uBXd/zWMmvQVrC/8X/p2gL7T4hcGJgPznbAnd68crLdKTh3
   SnSppbSYKHRwM4G0tGkdPDPjvXSHt1zIgzJoqGx5qxaDVlUf8LhCMuzGE
   Q==;
X-CSE-ConnectionGUID: WcGUAEs4RR6PG7k6ihvy1Q==
X-CSE-MsgGUID: z2UbXrdrQPmbKVAOie7cvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1408399"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1408399"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 07:56:39 -0700
X-CSE-ConnectionGUID: YwogONWMQXadWQEX98OVjA==
X-CSE-MsgGUID: 6LteufvBTzC4MT/wRurI3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="5421140"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 07:56:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:56:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 07:56:38 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 07:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+zcs/8d8IREYpLAtXmGClyRKmHx6enuoX5cQeB0u9q6Nptt7hUyJNSLoNL48CQNrKO127Jx6v37Ergm3Q1dqmwlpzcrRqfgXJtU8GK0pY+Kyy0fxMWJC3TSrKFkfTqtFml3ho21A6JCNqQWyFbkgLKB0102uQu4jc7LJnXRiS8lufp8eRO93br38kioVIfNB6hR3tehIWysV0uVpvVPdmh4kzDiu9MeQ82L02tzMk91c6Fl8EAuvchDeeKFd7BWWo5aPk9raPlr9yXNQrNgA5HvM1qlHAXgJ6q1bgciIcx/Bkn6049ZHvjxBliRZlqJIXYfQuXO4JiG37QnlrgHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnrfelN52PjZk0gZd9Y5uXLnWEDVXG4+u2JR5D5ajrc=;
 b=Emh5ZH8AGMmHFQSm3s1Whr6dc6q9N5LjxC6j9+BrxJhr/edF9iIGgp0oXnfNmCPx0yBy9REcIwUNwfTGby+N1UEiKrQvtAnVRidgPvDVR8iXKHbdUJznpdAFr9UL4b8dKIlBE1p9hQPxLUVhzRxoM5d5Ir/TfIxNOnVl2SW0+Q/VxfzVQuuGhGF+V/Q71OvrZ8yN9+6cbmzh2nbNmby5wMNmC42T/k2yR9V6UXpO+Judj45S1UemTxCI8PaHlTlqp2OsqumpLJKOz7zMXRbRgzZb4XCL97LBWHgUZd5NNOwB8f97FImd6/5cjvL06iUlv0oz6FVKM+KYVtbwO1GqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by LV3PR11MB8694.namprd11.prod.outlook.com
 (2603:10b6:408:21b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Fri, 23 Oct
 2026 14:56:32 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:56:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Ertman, David
 M" <david.m.ertman@intel.com>, Mateusz Palczewski
	<mateusz.palczewski@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafal
 Rogalski" <rafalx.rogalski@intel.com>, Shiraz Saleem
	<shiraz.saleem@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>
Subject: RE: [PATCH iwl-net v2 4/5] ice: do not block on the aux device lock
 in ethtool set_channels
Thread-Topic: [PATCH iwl-net v2 4/5] ice: do not block on the aux device lock
 in ethtool set_channels
Thread-Index: AQHdYryq1czVLVwGqUSnQdo+qsIBHbcLN9Mg
Date: Fri, 23 Oct 2026 14:56:32 +0000
Message-ID: <CH3PR11MB566895CE5BD6E1BBB6B13C3101E5642@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261023070258.730168-1-poros@redhat.com>
 <20261023070258.730168-5-poros@redhat.com>
In-Reply-To: <20261023070258.730168-5-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|LV3PR11MB8694:EE_
x-ms-office365-filtering-correlation-id: 5a86e983-0337-4be0-49be-08df3115d3a8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|18002099003|261021121427099003|22082099003|10067099003|261021123027099003|38070700021|11063799006|261009223027099003|4143699003|261022105027099003|56012099006|261022075727099003;
x-microsoft-antispam-message-info: qa6I+9EWf3gjpJhUKnlShPhppGPgh/ANm2AB2+4fLy+vWV2SqBU9o7O6NNzlFT9VbbfYKDZiu/N850YWBcAUCyRiPU6Rz/G16PmtEiPiRG/Os4esBcbNPmyCAPwWEFICFBZRr9N57d69V+qk89HXEohDiRJNnkh22skBCq6OsVVowkSa8H+NUBNgvw5RsLV3T1CnMMBDtVF+bRHCugvE024qIgFWbMqmTCdaQEOMD8YawUGv549fYRjvdbWEPce5vVzVQ265SI7sJvWm1crE+3WBJsUpvaU5/RXFBGV3ROsK7W9KC4mw5Vk0xOt1qlmH2gCpwNxz1uQmpzqZaN7JgGHCydFkem1yUfUsoK4PJnqUh6v26Ns72+G/AuyIEtHwWky/B0nYNARE7jKy8A965q1MU/z5KbuDnqKk11Guf8SpjDpZ5o4Wx28qNpfD36jitV+jrk+bMwx5Px16mvy9gdgvMUKuP1db7AxNle8WU6wiqZhf0T8w73u1CQO6G9y5gDzon+Y8XoiQG9nYH+i/7BAMAaI3o/woUeRXj5ltGktIvn5fFmlgRbq7WaVscSFq0TwZSu354sEbQJ+rSGtXwzy+Z4O0zRlwG+n0NjS3PyJQ/ct7uGoO/d6wXCjCmVlw2TsKKMN57h/VUclk10CEniiCyu+ukOMDu1fTjQyBGHulriO81Dx7IQ8eC/InGgXl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(18002099003)(261021121427099003)(22082099003)(10067099003)(261021123027099003)(38070700021)(11063799006)(261009223027099003)(4143699003)(261022105027099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H4iENuD12LimNiAAtMN8AW3p7C6jpvlia2ewuD6Z19x9fv9bsx7y5eE289Gf?=
 =?us-ascii?Q?y6JaLhGhfQHElig4o7Zs1UEEnHXZeuNBzpybWwXkcI7aEkLGhV4wAGPvyaQf?=
 =?us-ascii?Q?QY81yZt9oDm3aE3mxwNFhGg5Y/Wr+JRpiwdLTjBN545vWyzKxr5VXLopHb9q?=
 =?us-ascii?Q?+JUhCtM4rlWUp7GNJPGtrRcbtfl0Tf8GlOasHkBzo1VAo7MQzhSu/xsQLvOC?=
 =?us-ascii?Q?3rFt9DNguQs1OLvIcrdBDRfy+ZPKHMEsgyAgjUb4i0dDc4RHIsJz1JUi/Buz?=
 =?us-ascii?Q?vULrkrEDH57lr/Ax2Sv/vTIcC3PQ2F7wTqPeSerNXPJ3qa5JwiYfynMdNxaN?=
 =?us-ascii?Q?6pwcm7knIlhKcHMUwTAEup8fpKazmw+Ec/lolBv8arM3wEnbxmnzyqG8qviB?=
 =?us-ascii?Q?Y6zcyNc8KIL7iiRjGpRGMZVRWVoqN8GOZUJisZeOUfROlY9xsW2u81FLspu4?=
 =?us-ascii?Q?4iA29zYJhzizeP3W3+EUnEdELTkYI/IyMrlerat72xU5SRG2VUw1dYYHNaqn?=
 =?us-ascii?Q?BrnIaiu9mIonldDY3CM+bDIYBov0DlewSuFfZ304ibN3s2X4lROs5BfPTCEQ?=
 =?us-ascii?Q?qwQmCeVeF5aHFG3FTIWAyWR9nElbAPjesluGA9Cbrmb4K8UbyBe3/8X+Iw9L?=
 =?us-ascii?Q?tNzT68xCfzTsDdaeRFaFmoZK6GjFKXycnepXcWNTFBjIIPRzBtpjE3VfVNXm?=
 =?us-ascii?Q?kNV+jvQ1wAQNRX1UsQ/UjzysTt1hZ5SDXE55y2mbf6huo7c5Eq2UCI983hZA?=
 =?us-ascii?Q?U17kuXIXDYiTTpFc0cUKFDQaNKWGFJEU6ERQ4Flw0I906zAfSXFHbDai9fqt?=
 =?us-ascii?Q?4nr5uH6rBWbDJ1FXrPD2rhtWtD4LY4rddorOnFE0IiPoGQewbU9jEzgI1aRH?=
 =?us-ascii?Q?A8v153p9uqKgUnIo22rtVab1dbI70B7wcXaL5Xxwrdmx9RxkFtmQMOBzq5pv?=
 =?us-ascii?Q?SGLMnXSqD0UPvErd3o5Da+cw4+TvynSNrmzNf3mSHcNWpoSTA6S6CCSwibG/?=
 =?us-ascii?Q?ZQGb6k+qNZD2mjIn5XU3UCyER6HPvF5/OZ6PqNwmKwQNnr/7KXGrv2SfuJpV?=
 =?us-ascii?Q?WbAhWAwoRZzdRdDq/PkcMiD51PiDqD1srNGkiTvquzuHdSad2tQ5EEGb3XGf?=
 =?us-ascii?Q?J/pXcoC9mTHOjmXP1lEIaL3ZensfjQyZgi4yC3JD6IIPG7RK3nqLepUYeSQy?=
 =?us-ascii?Q?M+WcqTygAfgjzP+YYim7+8WXTRDyxLnNwJCIm0/O2CsTl0Qfdj9o1t1hNeX6?=
 =?us-ascii?Q?4H5aY0nF3z8oB+OD76snEVFpWgXpNrAXk8/VtDVE9D+gQbtcIMrn0Vu55GAD?=
 =?us-ascii?Q?PuG6jx1iDqQ6qWcL0r2GCZL5O485w59FMpzxp+g6pkYuU3jtnsZzBzdFmEAD?=
 =?us-ascii?Q?IvjfXrVNdiOSIL7OpbChvCIRlfbBlP1wkkmFrPkMCylVWcGXomEvhUqdn7gw?=
 =?us-ascii?Q?N4NZyXB8xkg6yfBlsvbIKeWBtCCyUw6wpWwCisyoisaOnBw18StZ943p8Qg3?=
 =?us-ascii?Q?V/nFDrgpEOX61tO124Od0tHSPgj1upVeugesDPRg1oNvOgPSEP0T42bgD+v9?=
 =?us-ascii?Q?AIjWk4F37VYBNCVsqt7CAeHYpKQ6tADVa768L4Xab1C2vcAx19xomQ4lFnIr?=
 =?us-ascii?Q?i8rz2qma68fEZmMg8LOUVgzdsrb+UgZpPQ1ejo7sAANNhmYPusd0yLT3Dde2?=
 =?us-ascii?Q?1yO4qzvg40oFtCvj6YGX/SHGW1xL/63+U6thEjXkpqKy7JLsTaosCbqunZIp?=
 =?us-ascii?Q?Hzd+5T8exDz+mqFxZ3ufC0RWaL9RGBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hguwTG6fyq46HRNT/lmNOynZf2w/4fJrYSbAeE+GazwL0QD4MPusvqKK09wBKSjKWcLLO6Mg70pcwwjKCN0nkQWIWf59p3hu1y+nYXpv/aFe7iLJISyhDD/CQDLzHecie+m5A5GS/HVSKlfVPy2Z5NLthGi7LI/3gMbOyr40816RgTrpp/8lGr/isHPw0Zy2C4I9vD9TMAxYcraAr2oAf8o4Od2JFOzUzq5XiHL7kpty5QtcmsXteK7YI+Ns2RDGjLZv6acwxRZEJOCWL/x/M3KsKkXaPHf3UyTX8ognkqI32xDpa54bqbtRGmOnK0hYY2z3yDTDHYA394NG2qSYrQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a86e983-0337-4be0-49be-08df3115d3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 14:56:32.4645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADSLphac2sZHzBgz23l2Y0kTM1qECvvZRgO+8eTNfNVFHa8nSYJQfMKky7R3gKG1JtzHgcPe77eAjIvF6tkKN/CAvdWhu/7aCkjwUAbo/F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, October 23, 2026 9:03 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Sebastian Andrzej Siewior <bigeasy@linutronix.de>;
> Clark Williams <clrkwllms@kernel.org>; Steven Rostedt
> <rostedt@goodmis.org>; Ertman, David M <david.m.ertman@intel.com>;
> Mateusz Palczewski <mateusz.palczewski@intel.com>; Leon Romanovsky
> <leon@kernel.org>; Rafal Rogalski <rafalx.rogalski@intel.com>; Shiraz
> Saleem <shiraz.saleem@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; linux-rt-devel@lists.linux.dev
> Subject: [PATCH iwl-net v2 4/5] ice: do not block on the aux device lock
> in ethtool set_channels
>=20
> ice_set_channels() takes the auxiliary device lock to test whether the
> RDMA driver is bound, and ethtool ops run with the RTNL lock held. This
> is the same inversion against the RDMA auxiliary probe as the one fixed
> in ice_send_event_to_aux(), reached through a different caller.
>=20
> Use device_trylock() and report the device as busy when it fails. The
> existing diagnostic is not reused, a contended lock does not mean the
> RDMA driver is bound. It is a netdev_dbg(), the condition is transient
> and userspace already learns about it from -EBUSY.
>=20
> Fixes: a6a0974aae42 ("ice: Prevent set_channel from changing queues
> while RDMA active")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2:
> - rebased on the new patches 1 and 2, the trylock now sits inside the
>   pointer test done under adev_mutex
>=20
> v1: https://lore.kernel.org/all/20261019065301.3983537-3-
> poros@redhat.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 5482a64c81c95a..dbc662d6233957 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3947,7 +3947,11 @@ static int ice_set_channels(struct net_device
> *dev, struct ethtool_channels *ch)
>  		mutex_lock(&pf->adev_mutex);
>  		adev =3D pf->cdev_info->adev;
>  		if (adev) {
> -			device_lock(&adev->dev);
> +			if (!device_trylock(&adev->dev)) {
> +				mutex_unlock(&pf->adev_mutex);
> +				netdev_dbg(dev, "RDMA auxiliary device is
> busy, try again\n");
> +				return -EBUSY;
> +			}
>  			locked =3D true;
>  			if (adev->dev.driver) {
>  				netdev_err(dev, "Cannot change channels when
> RDMA is active\n");
> --
> 2.56.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
