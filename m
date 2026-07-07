Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D20430CE0
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448292; cv=fail; b=MSCafjkekV25wob0H7VfC7vvqPA7s3mQ9arB+kDrdv4V+xfSnR7YaYGJTt46LaSYtSCAw6E49VVtKa9ddbAYtGlXEE6P0GM/pGNLEHkuUQ9ewuuVUBZPLp4/ytD6dvJkErB482I25/5WX0xlmjpOTJOFw3t1YXNE7AEH49zmqmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448292; c=relaxed/simple;
	bh=Qavs8GtxVTsZ0H+2ZU7A7KeCptULPTHHlPfr0GSyt74=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NURp8opferKwiVrHQ381Y6LEGe0nO8cMzTQ3StmdZUCSZ36KCaQ7Oi7tMkGw8ca6YYUYlrlBhuTtcF/3/DfllsL0BnB1cU5cXhRExl46yPG/fFWa7GrH5ybCFMyDHBtFwKVhBe/TRS3rKjhbhy9FS93X2K2cn4xNM1Xug4VnGPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqCmhC2u; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqCmhC2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783448291; x=1814984291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qavs8GtxVTsZ0H+2ZU7A7KeCptULPTHHlPfr0GSyt74=;
  b=WqCmhC2uHX4P2Xh4hclPJZMIDQLJW5Fs032iI5Rk23BXBZPq5O0r10cF
   9KYzWHJTbydxfEfU32rkW8PKlZ7pFEShiHMHwmpnX0IfbsmC/iVA08DPJ
   TOYFhtahbWmfoIfYXsnlVIIZOvit238Dy67U6WDrNwI508q+cGkYBCnWo
   FmTVVD5zwze8Zs1TJnyE1Ucqu3DOJxNl8+lE0fzFjWRMzE2+6PgXlX0Ny
   DiYWDpML6PdD/CrZMZT4U8oDyQEwqtcbOtkZdK5GcvszZKggwbbGIJgys
   25DodmXqFa7mMlSK7IJlNM7CIIjjJpYyYY0a1lXuSt2AWyw9RrdoAXot/
   A==;
X-CSE-ConnectionGUID: erot3lIdTqyKqFNX9Jklvw==
X-CSE-MsgGUID: VfWcPKuHRiids5y6GaKk4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94458629"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94458629"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:18:10 -0700
X-CSE-ConnectionGUID: mRl94Dr4TH6fIRT7SeDUpQ==
X-CSE-MsgGUID: wQW8YBk+SfWs+KixI7kzHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254712650"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:18:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 11:18:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 11:18:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 11:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWyxrGYzYaFb5l7vgjuUv5IeQUdGewkx1mv8/4LW0Oze0KkD/VDAqw6uau7URsAVqfE20qpIeRxZJ48X8NwfX867jGaHItA9H6DN7xAO6vUPjukHQSeMD/AGIzOKglJJmPqItAE+CikWDIFt5bgQivn0CxsbGvD2jCun1NQw+R/eEfML0Q1yDKmvrqJucPfn/akaURjfD/3xqQ9xuVMMXDWMhmEjeyXosfX0619RQHZWyY+pYKDf1p4rI5+s3gFiIYAWqXwpY07Z643c1K7+KSMjwehk/eAXkAl/GZPD09MpbST0upbURRQVRwQvkrwgO10O4BR0sh/Y0kjDp7FmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZorcVIzsCj9xOt8fux84uIyM+6DFsDyoT+zLDFWCC9o=;
 b=NzpHKv32JaI2gP/S/8lzWvlYgfdMEeUrY+S004WrW+sRLQ86bGHDDEpH48Pdc3CVfaqFd85oNuumfd8uGDuSPuY59HuWhEq2ZJOw9u0a29YCrbZ89V1FtFrmgHJcuVIgM4aP0K8GnMabGoV15aFYkrpS8FGFiPGA2zmdjzHgvSQq0SMw7H1EnM0uNwByIgXTW6AqIjHhf/gL3lJhIvw4BOX+emm3xQW7bS9TFLGvvFN8W9pAnj5Gu0ftRvr3eBK+L4goVMU+nV9qytNtyRkp7CB+kdSLh4jmNXaAHMYK1rB3X37Q1VjAPWeDuXMk1m05bojinr+Ss/LtCNp84Lzzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by DS4PPFFF98E87FA.namprd11.prod.outlook.com (2603:10b6:f:fc02::63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 18:18:03 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%5]) with mapi id 15.21.0159.018; Tue, 7 Jul 2026
 18:18:03 +0000
Message-ID: <ec899c62-35e3-47c1-8d42-47eff084d30f@intel.com>
Date: Tue, 7 Jul 2026 11:18:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
To: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra
	<atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Babu Moger
	<babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov
	<bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley
	<conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai
	<gsh517@gmail.com>, <guo.wenjia23@zte.com.cn>, James Morse
	<james.morse@arm.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, <liu.qingtao2@zte.com.cn>, "Liu
 Zhiwei" <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Peter Newman <peternewman@google.com>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
	Weiwei Li <liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <linux-doc@vger.kernel.org>
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
 <20260628-dfustini-atl-sc-cbqri-dt-v3-8-c9c1342fe3cf@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260628-dfustini-atl-sc-cbqri-dt-v3-8-c9c1342fe3cf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|DS4PPFFF98E87FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 0319f8c2-1253-4690-bf3e-08dedc5415e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|921020|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 5TqAnOV9avymrxUhV7dyJ6hk2u6TtPgWVswyK7dsTVcCVKpeeub70nFv6w3rrxhSv21yOAFuuRZLb3ft/cMFyCnxy4cPydU/TRyGvjeWiLRm8Zt7hX50GVQIpwVqOGUiTrcMh6FksB8FPVLxXZbbnU623AHQSCIdq7T8DvAqdSsLDaA28PZVKl1MmzSvG/K1LdxdLf1/lZWSr4V+5M/m/GuyqJivOlvDLZRH5NWkJlWNKlC38C1Dbry5H3mQQ/YM7SbzKfP5m2wLenwN5mck52Dm4S6HUgbgZ/jzrHrrFJDfVLGl1VNEUBJIX9VXXNKuK+918EAOWD8Yd4w7jCaqYz+w+OYVEit0RK86kjekbeNYjt1PyZTVrvdxIlmw+nnhONwScgN7htQtvXhmiLbNSkEdEI6EniDAr5YjjBBiGR3ET0lTpENo5FgS9lM7EvXtGkpwjBRen9b4rC1/DPviMwMh4cXnyLsATjme8p708TlJE1J93vX4hd92LxOMpZ9Luduf7vaLvGZW6CrlT84vTeII00aobMor6Pkrep3X+suly5TeiplneWyssVOgKtgTgCc74NSyrdsn3dTRa3by96LSZmEVJaDeCZc5hZZMr008m2Vw1QPI6AWcrAWPzfu5722l/ARG1vfj+YDEmU5fZah8SMq+/kBYIyLdwecF48Hk12PZlR1LDkzvNlJSYL8YADrLi7oZmHYsemRWik83qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9wdVdPY0s4S2duUFJiNS94YkNqUGFSMXEzV2xYOXFmdUh1QmVsZDZQc0t3?=
 =?utf-8?B?SWVhMWI1QUFqNnl4ZXlLUmMrN2VPUi9yK0UvU1hXWTVHZUVWWlBVb0RsajVs?=
 =?utf-8?B?S05Vc1RLTURrSjBweDh2SlNpd2o3MXd4Y1RkRlY3ejQ4bDZ1TXpza0JSUEtS?=
 =?utf-8?B?K1JlY3FneUVYSURySXJENUlxS0Q2NnAwemg1LzJCTVJXVVdQQU45dlFkOVJv?=
 =?utf-8?B?OUtOYVpyYXJuSGhPRWhUeGFtQXFuc1V0U3AzZldoQllPSWZ0T09lYWs5M2hu?=
 =?utf-8?B?Mjc0aHAvVGQvc3pjdFA4Uzh5UVRubnFsaVphbzM3SndNWGV6Yjc5UFFOanBq?=
 =?utf-8?B?QnF0MzRWbnZZS2tJVG10TFBHZHpNMnR0WG5iMzBKQmR4RlViMFZIekJybVBV?=
 =?utf-8?B?RU9kaVozTldSSEpoWnJWeDVjdWU5SGJyWlA4WjJoSWhWbGs1ZHhtZ0FiU2lp?=
 =?utf-8?B?Rjg0R2ppQVE5ZW9VZWNhSzB2MldOdjU5U2lVU3JvdGMyMUJ4WGRiMEpXSUJC?=
 =?utf-8?B?Ujc3UjlUU0x4MlRqcS9ncmdqQjRVZnlsQ2xnNkJVMG4yQU9PQjRRYjFBMWl3?=
 =?utf-8?B?Wkd3cXViOTdROTh2RWVkQm9JMUFzTmRLVithNk1ja2hqbmZDQ2s0bVZhc3Zz?=
 =?utf-8?B?QzBIdGNwcEJNM0trS0lEa1dmV09IVEdLaTFUZTFuTnRoSFJhMUVhNFhERHRZ?=
 =?utf-8?B?TWU3ckdoOFJ3SFR3Nkd5di9lRmw5d0JXS1lDemhIY2g3bmJremhrazZtZlNQ?=
 =?utf-8?B?VC9henJhNTRzbnZtQ1NaeVZ0a25ZTU4zK2hxbjU4SjNsQ0xFVURGdkJJZVRJ?=
 =?utf-8?B?emRXOWJDaVpHNzNtQkw2cnRZVGFlc1ZXcjJROE96RFhvZVMvYkhhZzU0VTNZ?=
 =?utf-8?B?Z0xyZzlUOTlNcEpsZm9JM2l6RjBaT0JBallNc3N4Z0VEbTNrRkNoNkhUbjlR?=
 =?utf-8?B?cUlTbVJBYjl2OFdkNXhiOGpVQWRpU1M3bGFYK2hoTDdaeno4YTRMb3RPSUxs?=
 =?utf-8?B?QnZ6bTNBa08rL3QwckFseVU3MjBJalp2TG1vcmRrdzhXblhPcGZ5d0x2UmNP?=
 =?utf-8?B?bTFURSthVnE3emhicklXT1lVc0NaMTJUTUpjZVVidXFwVTl3UjBzZ0EyTmV6?=
 =?utf-8?B?VUhSQ0pWR3hmSFUzUGVuTHlhRXJidXhUMHBTQnVkYm1LMGk0M2E4SnN0Z2JY?=
 =?utf-8?B?QU9CN2ZrK2hTeWJSMnhBNkF0QldHdFNJUW81cWtyczdKbTZtTTlmN1BSZUhZ?=
 =?utf-8?B?OHVJT3dvaUlrdXczRmxCQnBzY3FObHdheEFtby9KcjZ5SHVGYTQra1hodytR?=
 =?utf-8?B?U1kzYlZsTjgvYU1kM0pqRUtGbElSUFpFVUJHd2dHVHBJQnpNUGhIZDFxM0c5?=
 =?utf-8?B?NHd1VURWZjJIbUFnT3o3c1FFamRBTUFsUXBTRDZWVDVQcWV5aml3bnEyM2Rk?=
 =?utf-8?B?YStIcVdObHd0M0QvY3hPaUgycldEcVFDMjlkaHVSWlJQT2tObWNBUXd5Y2pM?=
 =?utf-8?B?T0VNTUdTaEZEcnBvZXdmNm9LZmZoeGNmR29nbk5OaURkMmJxbXhsREJDM0xL?=
 =?utf-8?B?MDdPN1poLzF5WXMra1YyeW9KRTdBOXc3SzRKcFNNa2pJR2xOcHBxQ3JXc2tK?=
 =?utf-8?B?WEovdXFLM2g5Z3gzb0FSZ3YvVC9rZFUyNUhvZEhjZHNyYWNFUWl1WWRqbEg1?=
 =?utf-8?B?UVBEUjZtRjVxenRGcWpBRXJISUJFdGIvZ0RZYUtkeG5YMGVSQmdOR3hkM0h2?=
 =?utf-8?B?Mzc1UlNXM0VXVmErN09aTm04Mi9IYUpkZjhiSnJ4dVRkWDkwUjBYNXZDRGZr?=
 =?utf-8?B?RXUvV3dTR0VsT3VsRzBUOS9adldidVEya1JQZDFKRW1HWk9ERTVnaTR1dzVG?=
 =?utf-8?B?N1MvQUREUGRvaEJYNFFCMlZGNmFxOGNYcjdNRkRGK0tRUHhodW9YcjdMSC85?=
 =?utf-8?B?Mm90RFZYM1lXRERYL2RwdDJWdkF6U3RWY3lja1lSV21PeU5Uakwrd09hbDQ1?=
 =?utf-8?B?RkJFcGxTUEFOM2wxZHltQnRQSC9Fcnk2Ymt6cG55ODVyZGxHNjVlV21wSStQ?=
 =?utf-8?B?QVFudlBGMG5ZOTV5aWgrdkZwSEFRUWpDZ2ZlZGtvTmVZSUl0ZERQbmd2Qjla?=
 =?utf-8?B?S1lIc2xpc1Uxc280alQ2TFlBUUJUNWtxWnpxQnBscDFBSnZvUVB3ckk1dWsv?=
 =?utf-8?B?RzBLY2FFUGRsUC9NYVpIUDVVeVpjeTVJTHBXZDVjZDVjYkkvTmo4UnRvdXlM?=
 =?utf-8?B?WlAyMTU3MFh0cG4rNStXbkZ0MzhuVnN3WXpoTlBleWZpZzNubkg5ZjNadm1r?=
 =?utf-8?B?YkdiSDZIendwTUl3dnl4eG85NHpJSEJDNmtNcFpiUWszaEdjZXNqQUduSmtP?=
 =?utf-8?Q?KjRO8AA8nGgT5X/M=3D?=
X-Exchange-RoutingPolicyChecked: sdQjpBUsV6DSRJxVFTG99b2/Hr+jErpmsHu1nJCuoDbwoRT4v+IlOFCM/BkumOrYdMYnQk5fBNFmvlg2XvbW3UdcHUxn4rZ7PKbMbXVElZ6oCvq0EAl0i5kRIAhBsTI8OiGQgI1x1nhBNldgG4TwQIlMtYwxBu1sTDeDHJhi4dQ2EssGtHpwING+V09l17xoUCla68em3R5gSjJAheC5qorKgDWVk0bn6MSnBLYKgcubALtutmqUZ4JotdGmE7DEduLlFw1vIBf63AqJ2lCpEz9J/DKI1Y6vDbSuIFCfVoUkf33kPbpEqAcjtFX4NvbxTYo8vwCIOPs82q4gN8Qt0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0319f8c2-1253-4690-bf3e-08dedc5415e7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:18:03.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wAxE1g/h0nojm5xZaDUTAk1E4XBN3UqkIXWZpCg4qxMcDHCv50bUEPYAGcoZDIgcUJoLaIeJwcCixKQeFW9RVDStRz2p7gr28zv14H0P0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFF98E87FA
X-OriginatorOrg: intel.com

Hi Drew,

On 6/28/26 2:18 PM, Drew Fustini wrote:

...> diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_capacity.c
> new file mode 100644
> index 000000000000..2172432eb328
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_capacity.c

...

> +static int cbqri_capacity_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cbqri_controller_info info = {};
> +	struct device_node *cache_np;
> +	cpumask_var_t cpu_mask;
> +	struct resource *res;
> +	u32 rcid_count, cache_level;
> +	int cache_id, cpu, ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(dev->of_node, "riscv,cbqri-rcid", &rcid_count);
> +	if (ret) {
> +		dev_err(dev, "missing riscv,cbqri-rcid\n");
> +		return ret;
> +	}
> +
> +	cache_np = of_parse_phandle(dev->of_node, "riscv,cbqri-cache", 0);
> +	if (!cache_np) {
> +		dev_err(dev, "missing riscv,cbqri-cache phandle\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(cache_np, "cache-level", &cache_level);
> +	if (ret) {
> +		dev_err(dev, "%pOF: missing cache-level\n", cache_np);
> +		goto out_put;
> +	}
> +
> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto out_put;
> +	}
> +
> +	/*
> +	 * Associate the controller with its cache instance via
> +	 * cacheinfo. The matching cache provides the cache id and the
> +	 * set of harts that share the cache.
> +	 */
> +	cache_id = -1;
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, cache_level);
> +
> +		if (ci && ci->fw_token == cache_np) {
> +			cache_id = ci->id;
> +			cpumask_copy(cpu_mask, &ci->shared_cpu_map);

The way I understand cacheinfo::shared_cpu_map is that it only contains the online
CPUs that share the cache with this CPU and if the CPU is offline then shared_cpu_map
only contains the CPU self.

It is thus not clear to me that this handles all the possible CPU online vs offline
scenarios. For example, if all or some CPUs of a domain are offline during cbqri_capacity_probe()
and then come online later. It is not clear to me whether cbqri_controller_info::cache_id,
cbqri_controller::cache_controller::cache_id, or cbqri_controller::cache_controller::cpu_mask
are needed. Could the cache ID associated with a CPU at the time it comes online to dynamically
associate it with the resctrl domain that is indexed by the cache ID? This may simplify a couple
of flows.

> +			break;
> +		}
> +	}
> +	cpus_read_unlock();
> +
> +	if (cache_id < 0) {
> +		dev_err(dev, "%pOF: no online hart reports an L%u cache for this node\n",
> +			cache_np, cache_level);
> +		ret = -ENODEV;
> +		goto out_free;
> +	}
> +
> +	info.type = CBQRI_CONTROLLER_TYPE_CAPACITY;
> +	info.addr = res->start;
> +	info.size = resource_size(res);
> +	info.rcid_count = rcid_count;
> +	info.cache_id = cache_id;
> +
> +	ret = riscv_cbqri_register_cc_dt(&info, cache_level, cpu_mask);
> +	if (ret) {
> +		dev_err(dev, "failed to register capacity controller: %d\n", ret);
> +		goto out_free;
> +	}
> +
> +	dev_info(dev, "registered L%u capacity controller at %pa (cache_id=%d, rcid=%u)\n",
> +		 cache_level, &info.addr, cache_id, rcid_count);
> +
> +out_free:
> +	free_cpumask_var(cpu_mask);
> +out_put:
> +	of_node_put(cache_np);
> +	return ret;
> +}
Reinette

