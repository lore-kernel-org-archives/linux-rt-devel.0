Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC67430CE0
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448246; cv=fail; b=X7d5pfd/1G9XA9sE9Huj2Yn9tTKy7EMOGbFrrbG1puOW68oNy/Qqns0Gi/r2gWejyJP3QLudo70zV88KceIWjrJeElivgFFldIh5BWfPWYBs0iqGBMXv38LgwwEqJNVhGzTZ7+QAYNssvwOMQIjuayNMTceqbqv7pH5G/3scss4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448246; c=relaxed/simple;
	bh=3UbQD7Br6hx6IP8epzGjxknIv1LlkRJLgtZ0+ZXnTMQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=grPWmHFbFB8P77CgqQMuctjgD4ReGHK8UfcCzLh+LmZRFqQXxgqL5JQF8dLzIedKMO9J+DkhDRqf9HOnj3jJ8Fkr2mSauXV4Bp4bZKrLBDi+pTDNNyuT76vr8TEeG32WJjOxI1Jnf7ktLCkge9UOiaCv1fNP75WodscTStyykFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezM3bOjr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezM3bOjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783448245; x=1814984245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3UbQD7Br6hx6IP8epzGjxknIv1LlkRJLgtZ0+ZXnTMQ=;
  b=ezM3bOjrw6YQ+zXg19w2GvtyyWrw7ZaJKgLnm0chnUHPBZlQjQxEpe2F
   jig2fUVyM8ucN6wTWaLLMIMg96chfQCVgww/LwSfd2qVTof0MqzhIOTRg
   L2kqNFp8E1yqLSQfLpS8vUI1De743vGMnDW/VZQ2FmTsE6WEtC90C+au6
   qAwciRDfw+5dv5ssnGEygLT7lZQcks9JkO3GdY/aN5KiRJx8j/LBmhQwv
   T3pHoyFm9IPNSDRc5J7MiW17mZOIs6CEkJxLzOIUFZpntdjDJdTCd5RNL
   npAzNWYWUfKaA5+SF09zEgK30DnagidCgoMJYG6SX+ZEY6SlRP5v0fOTY
   w==;
X-CSE-ConnectionGUID: JVJejt26SgG2yvvsxOQZJA==
X-CSE-MsgGUID: r0smz7fqTsejWZ0Pu21Cqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="71625701"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="71625701"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:17:24 -0700
X-CSE-ConnectionGUID: fr7r76jaSL6k8v7Un7qE9A==
X-CSE-MsgGUID: m9ELBU1qSlmp529TPgBFuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258369693"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:17:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 11:17:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 11:17:22 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 11:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqNGy4L8dWUW4sF/2ILx7FrWo4geUGEoW2J4MLDzsjVywyZqVAwU6xdq6QBqHd1ajE9jgUVDUaJ9Os1385m2yzuF9RfyBmLe5BfI9gc3n5T9PeejXTlt9Cc/aLZk80zbXtLJUmqFjBRKGCU2YPgpGLRFkrWEQjGgBxj1hSKire6icRZCjl7q0hbHfFxOviVjoK1f3MNLY/Fz+mGAze9nJREEAfFJpjjzIegr8IFY+X3BqNqJRwB2mfyVFiFL5wWW66zrTGkOFwojBhyFNFRRorJ2H51WhPy5HFr9v0gk9lAZE53KQXy38ZYZz2DjvidYXS80DShvFoOKf2QtFnnZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNV2zjOceUyEXfDDDNBnAyxB06ER5GE4j9DdP3iekC4=;
 b=uMI72X8a4rIxt4YILXxg9Hn8YMHhtJtFF2BwWOPEyCYaQi1HHIS9S5Z9PRb40Kz8DK0yZd0jzJ6CSl24tFS0SXHN/mmz70S2xIp29NsMY7iBZCgy/wnqtfpS6NZ8Ltq5iPoCFa0Q8b1zYwlVF9bYVhI+syRFwORy949vsasPxRsDITGkXEHwuTb57Gywp27aqZTeorl6elL8QxXzMOKwhNKaIHYdQIMxXQhojss8R0pO/TXIl/o3dJZEb8UdlEQ+CRcTFanZC/jOx1GhKdO25pydS6s7sAItN1Q0rvSImXmhHspvcKKYWVmCI3lokBi+l1rGVN4YM5KbKuHaPhN7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by DS4PPFFF98E87FA.namprd11.prod.outlook.com (2603:10b6:f:fc02::63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 18:17:18 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%5]) with mapi id 15.21.0159.018; Tue, 7 Jul 2026
 18:17:18 +0000
Message-ID: <3e7070fa-16f3-453e-9f0e-9c1a2ef38f9f@intel.com>
Date: Tue, 7 Jul 2026 11:17:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra
	<atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Babu Moger
	<babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov
	<bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley
	<conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, Fenghua Yu
	<fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai
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
References: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
 <20260706-dfustini-atl-sc-cbqri-dt-v4-5-e75c20201d64@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260706-dfustini-atl-sc-cbqri-dt-v4-5-e75c20201d64@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:303:83::30) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|DS4PPFFF98E87FA:EE_
X-MS-Office365-Filtering-Correlation-Id: de878154-04da-467c-52b4-08dedc53fac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|921020|22082099003|18002099003|6133799003|3023799007|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 1fjRqyv4YoWOtbqnIEzZF/tGpM6SkZgIFrorrSEmZvmUp1vsiDdE2trWifiShhlNdgC3dRuprNravmAtF2wlG70HhysQMzGtExEUDOS8KIQm8LcSQ1npbSUaAJ6ayA+a8cTXFe4XZ6e005Gpx7t3gwQHyh7FvSC3b4BComzbxGL1nvAijdas9JRHf7gYXpz5eBErm3/E4W7H3g4Sps/L5M37aSl0Pm8zf/zmPLZ5DF1qP4x/265iQnbY1PhlLmobxOBLwtnVordfyrndODuGZpgCC7WNclL0B+t6fAM+zwqzRVR4MdyLMW/VdGzo2iU0uuIKLblxVB+1N7rGMzwwWaMNi4H09DTfwexrY+sJ6QEuhARzeH/CJB80NErk/yvTu/y28VZiToZSSer5tBhyFFq/E/kBeiuELP8o2G5xyAGqmHK8Qw8RPfzY5Z4IT0AS5eIoUAmOZbtHTq7WhlK0y4Dp+DyXpPkJr9sXIw+ZJnSzlsAFghFvhGk2Oer9T5tNrivghB99TdsFnnqiafaU3grwme+0VCw+10f3JpfTeTK+isWZfHgTQc30DEBjrIsvlhVOzt73VWiDs6N1rSgI1oNY6LXkwjPg1LBnf9q5ao22TZ9Dh1dWm4602EFBhaQJuNwr2n1clSY0kcLTun8rI9uw7bPgMaCp4mWaRq5j8SNbXqOPhRdoGr/O+BEiCwl3sTDiQ7O1ocJTvmNGsYn3zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS84YjF4R2lSMzlPRE9Gd1FqTjA1K1JtbitTaTJBaFZGaHpRY3NZbXJVZkE3?=
 =?utf-8?B?YUxOSGNlNURXdmhnY2NLRGJzaW9QdEV5SnZITHZwWE5OcUNVMis1ZE9QM0l2?=
 =?utf-8?B?ekJTQ0YzMGNoMEVRNTJNYVlXaHMyRXVuZ01nU0RoVDhuTGRHVGhjS0VJZHNl?=
 =?utf-8?B?SkJxbHJtS3VIYmhFaWZEbXI4SnRSd3BSbFFOMGRLN2xzVzVqYkFXcDc5dkpQ?=
 =?utf-8?B?VU8ybzJqRHlzYzJ2SCtsbDdvbVl4MHI4TnRUUEQrbkpxRlZHU3VpY3dPVmp6?=
 =?utf-8?B?bVdlNkxZdm16dkJaRzhVdFk2V2JhTk9mc092aHRyM3hIT3JEckF6Q3BuQmRt?=
 =?utf-8?B?MTlaQ05sSmN6VW1NaDVVakh5VHBKRlZUU2I3Z1Q3c0dSdVZXVmpJUDZyV0lz?=
 =?utf-8?B?VFBhSkE2NTYyVnVjSENiU1AvVjloNjJQQXlNclRmeUlpemwrN0l2STZhdUZm?=
 =?utf-8?B?V0dGdzFiaXdIMmcwTFozcTlwamRjdjVuMmlYK3NKc1RnSkJCbzU3SWh3cmpX?=
 =?utf-8?B?TmFTUStiZ0dLUytHZXpveFJkR3BGOFBtSXlWd2xEeURaS3RFandSZ2xhQVFp?=
 =?utf-8?B?SytZWDRPNFJGZGpmSDd1T1lwVjZhRnBtcVlkYTQyWlBWcGJUVUtUOC82V1JI?=
 =?utf-8?B?RWpPZVV0LzduTjFXUjI5SXdrajdPOXFVSFZzZUxRak8xR25MdlRaNjM0L0ZG?=
 =?utf-8?B?RVRaSDBEdGVERVEyNGxBdlRsY01sMUZjeENyanIzTlNiRUgzelBtUncvLzdJ?=
 =?utf-8?B?Z0VKYnNuR2RVckg0KzhPZjlqa3FSTUtUOGtYS2FJQUUreWZJN0hld0tzMG9D?=
 =?utf-8?B?S0lUeFlaaVI2cXVZME5ZSEFtTDNVc0VwY0hPbDBvZ1NlRDQ5amMxTWsrU2Z0?=
 =?utf-8?B?bW1zcldWUm1SQm5RNmRwaHduNlo4YkVRakNTcWVMdzVkZEZVRGU1dHAySm5S?=
 =?utf-8?B?bm12ZUpYWkVwdVZVYjZ6aG5GSmQ5cG5BbkFvcXdlYVJWYUpuMTh4NmNUM2w3?=
 =?utf-8?B?S1ppUFFBT3BpcjZxQ1kzUC93SFFraHA2bjg4RXpKejhIOHR6d2xwSnczQVgr?=
 =?utf-8?B?TGFnQ25EYUFyZUY0b3pGK1ZpMmhLSSttOGUrTDNSZUJpQkI1VC9uWDVZYU5j?=
 =?utf-8?B?QXdrRGdwZHZvV1BCU0JIZHRYdDNiWnRGeVJiZUpUTmZqcDNwaVlrQzFOeWhs?=
 =?utf-8?B?clVzelo5S1dDelV1R3Q1OHB5bkRqUW5MUlZlM21HS3BOS3d6dUNXUnZrTlA4?=
 =?utf-8?B?Z1oyRW4wYUtaNGpxVFpueGU4VXVjc1RiTmhZWHhqSk1LKzY0bFdUbE40ZUZk?=
 =?utf-8?B?UWpPMzVxaDFiazM5SHJFcU9rY0dmczZqUFdIUVJPUFo4YytWTUxsNjVaNnly?=
 =?utf-8?B?Zkhod2s2YUcvTW1MSmswN0xxNEpPOXdqUVVyUm5LZGFSNWlMTzNNWFlQeUo4?=
 =?utf-8?B?ZWZtb0x0TWxXSDhQVE16aGcwV2p4TE5uUEk4UUdRNjhqMHcxRUdzYWxkdXB6?=
 =?utf-8?B?RURIOVFEWE1vUlhHVk1iMGZ5bGFYTlE3T2JyWjBSazhqZjVIZk8rbFdPYjZ5?=
 =?utf-8?B?MXhYR1JoMnN4OHNuc3NncS8ySmJic3U2bGY2Rk90MWMzSHlFY2VERW94cEFK?=
 =?utf-8?B?Q2J3ZEZCYlFjZE10OVVsSE5JUG1DMDNwVHpINy9CVDduekw2cFh6Q3FSQ1Y1?=
 =?utf-8?B?a09uNzQ5bERyNjJvQk5YakF5WE1zdTllOU81WUNHcjhIYWN6OTFtQ1doQ0pQ?=
 =?utf-8?B?WEJQb1VLSjhHY0N2SlJZcTJXS1Y1ajJ1TWQ3RnBESitFR1pLSXJ0cmRtVGdN?=
 =?utf-8?B?azNzUHlHdUcyd2NxWTExNjZBc1RnOFRKcmphaXRWalNDc1VVK01qWGMrREJq?=
 =?utf-8?B?RGpsREdnbWUrWHljNy9kUFd3bGpmNzFvU1JEVTVwdzNFb013cGNjUHRPQ1dm?=
 =?utf-8?B?R016NitYL01YU2NDWmQxU3B5MkNaYm41UUxEWlpPeFdPbE1HdnY4c01nREwv?=
 =?utf-8?B?UG1xZU5ncm1jOVlPRHMrODRDSmR6N0FYZjI3ckxNTXZBWGt3anMzM2FyTCsx?=
 =?utf-8?B?TnplUlJtTXlmZkpHbGhmQ1FMUWNZZERaanpJaVVrK3ZNME5rbFpiRHhWZERh?=
 =?utf-8?B?a3BLY2lFMW44bk1HN21NcjFTY2tpYmNwckhYZWN2L1ZUOThXRlB1VkFEZUVF?=
 =?utf-8?B?bWZLOFFLVlZhcjZoOTNoeGRVb0thTDNTOXI0VFFJYU5YMUl4K25PbXBPakc0?=
 =?utf-8?B?UElraGNpbEhWeWJKb3A5N2ovME0weVNXSUtWajJobzQySEhPc25Pb1AxNGxT?=
 =?utf-8?B?YWsvSE9sem1PZ1RuSnJoc0lRUE8vOVFCeFFTR0hZcVg2UFZwUzd0eXpDN3pv?=
 =?utf-8?Q?reuOsxa5khGFtL18=3D?=
X-Exchange-RoutingPolicyChecked: st+7qAmBeTTE7dYWNNWsQDwAmerD4FxqcIh5QYjSPHGYf8WqlQ50GGsMPBMtBld+WRpOmoN17V59WnPCCYYnXgZd2Vv0XASZkLymfq+fvsbADadNfqkQjDW92Wz8gX2gChkmKJqVobgEGn/EqqfP5AAShEjLXuWHiIh2jcC+TFKiDDUEEU+KFtP6hQuIBSnW/waDv+W38KwPkQEwEh0smggrdoC0Oj0yEHphEzzKp8eO3WdmYg3cCunpQTTXllTGrt74/wtgvsvG9kPJAqGYUYCi6r1CNclnql2lZlqfkY/LAkHpxSXS7QT318ZgGTw7qOHdXXWKcKRpI8bDSyrNTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: de878154-04da-467c-52b4-08dedc53fac0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:17:18.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3XJlzwwM/ir5HE+K8yJy00+6tpxEGMYK8huih8WFGsYcVC71pOTpaa/eqShOOKyF+i0fmZwmnS2rX79sFC+D2Ow7xFY4AbCR2CEBT+djWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFF98E87FA
X-OriginatorOrg: intel.com

Hi Drew,

On 7/6/26 4:06 PM, Drew Fustini wrote:

...

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
> new file mode 100644
> index 000000000000..cb12a868561b
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c

...

> +
> +/*
> + * fs/resctrl unconditionally references the symbols below before checking
> + * mon_capable. They are stubs for features CBQRI does not yet support.
> + */

resctrl should not access monitoring related arch functions if the arch
does not support monitoring. Could you please highlight which ones are causing
problems? From what I can tell, the first one below, resctrl_arch_is_evt_configurable(),
is indeed only called via resctrl_l3_mon_resource_init() if the L3 resource is
mon_capable.

> +bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
> +{
> +	return false;
> +}
> +
> +void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
> +				 enum resctrl_event_id evtid)

Similarly, this should only be called when reading monitoring data which should only be
possible if the resource is capable of monitoring.

...

> +
> +/*
> + * Walk cbqri_controllers and pick one capacity controller (CC) per cache
> + * level (L2/L3) to back the corresponding RDT_RESOURCE_L*. When more than
> + * one CC sits at the same level (e.g. one per socket), they must agree on
> + * rcid_count / ncblks / alloc_capable. A level whose controllers disagree
> + * is dropped, since resctrl exposes a single set of caps per rid, but the
> + * other level is still picked. The first matching controller wins.
> + */

It works but I find it to be a potentially confusing approach (just a personal opinion!).

> +static void cbqri_resctrl_pick_caches(void)
> +{
> +	bool dropped[RDT_NUM_RESOURCES] = { };
> +	struct cbqri_controller *ctrl;
> +
> +	guard(mutex)(&cbqri_controllers_lock);
> +
> +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +		struct cbqri_resctrl_res *cbqri_res;
> +		int rid;
> +
> +		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
> +			continue;
> +		if (!ctrl->alloc_capable)
> +			continue;
> +
> +		rid = cbqri_cache_level_to_rid(ctrl->cache.cache_level);
> +		if (rid < 0) {
> +			pr_info("skipping controller at unsupported cache level %u\n",
> +				ctrl->cache.cache_level);
> +			continue;
> +		}
> +
> +		if (dropped[rid])
> +			continue;
> +
> +		cbqri_res = &cbqri_resctrl_resources[rid];
> +		if (cbqri_res->ctrl) {
> +			/*
> +			 * CCs at the same cache level must agree on every cap
> +			 * resctrl exposes globally. On a mismatch, drop the
> +			 * whole level rather than expose one controller's caps
> +			 * while programming another's. The other level, and any
> +			 * other QoS feature, is left untouched.
> +			 */
> +			if (cbqri_res->ctrl->rcid_count != ctrl->rcid_count ||
> +			    cbqri_res->ctrl->cc.ncblks != ctrl->cc.ncblks ||
> +			    cbqri_res->ctrl->cc.supports_alloc_at_code !=
> +				    ctrl->cc.supports_alloc_at_code ||
> +			    cbqri_res->ctrl->alloc_capable != ctrl->alloc_capable) {
> +				pr_err("L%d controllers have mismatched capabilities, skipping this level\n",
> +				       ctrl->cache.cache_level);
> +				cbqri_res->ctrl = NULL;
> +				dropped[rid] = true;
> +			}
> +			continue;
> +		}
> +
> +		cbqri_res->ctrl = ctrl;
> +	}
> +}
> +
> +/*
> + * Fill the rdt_resource fields for one picked rid. An rid with no picked
> + * controller is left untouched so it stays out of resctrl_arch_get_resource().
> + */
> +static void cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
> +{
> +	struct cbqri_controller *ctrl = cbqri_res->ctrl;
> +	struct rdt_resource *res = &cbqri_res->resctrl_res;
> +
> +	if (!ctrl)
> +		return;
> +
> +	switch (res->rid) {
> +	case RDT_RESOURCE_L2:
> +	case RDT_RESOURCE_L3:
> +		res->name = (res->rid == RDT_RESOURCE_L2) ? "L2" : "L3";
> +		res->schema_fmt = RESCTRL_SCHEMA_BITMAP;
> +		res->ctrl_scope = (res->rid == RDT_RESOURCE_L2) ?
> +				    RESCTRL_L2_CACHE : RESCTRL_L3_CACHE;
> +		res->cache.cbm_len = ctrl->cc.ncblks;
> +		res->cache.shareable_bits = 0;
> +		res->cache.min_cbm_bits = 1;
> +		res->cache.arch_has_sparse_bitmasks = false;
> +		res->cdp_capable = ctrl->cc.supports_alloc_at_code;
> +		res->alloc_capable = ctrl->alloc_capable;
> +		INIT_LIST_HEAD(&res->ctrl_domains);
> +		INIT_LIST_HEAD(&res->mon_domains);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void cbqri_resctrl_accumulate_caps(void)
> +{
> +	int rid;
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
> +		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
> +
> +		if (!hw_res->ctrl)
> +			continue;
> +		if (hw_res->ctrl->alloc_capable)
> +			exposed_alloc_capable = true;
> +	}
> +}
> +
> +/*
> + * Create, list-insert, and online a fresh ctrl_domain backing ctrl on
> + * resource res, seeded with cpu and identified by dom_id. Caller must
> + * hold cbqri_domain_list_lock and must have already verified that no
> + * existing ctrl_domain on res carries this id.
> + */
> +static struct rdt_ctrl_domain *cbqri_create_ctrl_domain(struct cbqri_controller *ctrl,
> +							struct rdt_resource *res,
> +							unsigned int cpu, int dom_id)
> +{
> +	struct rdt_ctrl_domain *domain;
> +	struct list_head *pos = NULL;
> +	int err;
> +
> +	domain = cbqri_new_domain(ctrl);
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
> +	domain->hdr.id = dom_id;
> +	domain->hdr.type = RESCTRL_CTRL_DOMAIN;

Please also initialize domain->hdr.rid that is referenced by the often-used 
domain_header_is_valid() helper.

> +
> +	err = cbqri_init_domain_ctrlval(res, domain);
> +	if (err) {
> +		kfree(container_of(domain, struct cbqri_resctrl_dom,
> +				   resctrl_ctrl_dom));
> +		return ERR_PTR(err);
> +	}
> +
> +	/* Insert sorted by id so user-visible ordering is deterministic. */
> +	resctrl_find_domain(&res->ctrl_domains, dom_id, &pos);
> +	list_add_tail(&domain->hdr.list, pos);

The domain list became an RCU list when resctrl started supporting MPAM. 
commit fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks") contains
a great description of the motivation and the different accesses that the list
should support. Historically resctrl always accessed the list with CPU hotplug lock
held for which above is ok but there are some planned changes as part of a fix
that accesses the list via an RCU read-side critical section. Even with this addition
there is no immediate impact to this enabling since it is related to the
MBA software controller but I think it is best for archs and resctrl to agree on
how the domain list can be accessed safely.

For reference to the upcoming resctrl usage see
https://lore.kernel.org/lkml/4c88e01e29df638d9ecad71b2ee3b411e24067bd.1783377598.git.reinette.chatre@intel.com/

> +
> +	resctrl_online_ctrl_domain(res, domain);

With the transition to RCU list the domain should only be added to the list after it is
fully initialized.

> +
> +	return domain;
> +}
> +
> +static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
> +					unsigned int cpu)
> +{
> +	struct cbqri_resctrl_res *hw_res;
> +	struct rdt_ctrl_domain *domain;
> +	struct rdt_resource *res;
> +	int dom_id;
> +	int rid;
> +
> +	rid = cbqri_cache_level_to_rid(ctrl->cache.cache_level);
> +	if (rid < 0)
> +		return 0;
> +	hw_res = &cbqri_resctrl_resources[rid];
> +
> +	if (!hw_res->ctrl)
> +		return 0;
> +
> +	res = &hw_res->resctrl_res;
> +	dom_id = ctrl->cache.cache_id;
> +
> +	domain = cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
> +	if (domain) {
> +		cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
> +		return 0;
> +	}
> +
> +	domain = cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);
> +	if (IS_ERR(domain))
> +		return PTR_ERR(domain);
> +
> +	return 0;
> +}
> +
> +static void cbqri_detach_cpu_from_ctrl_domains(struct rdt_resource *res,
> +					       unsigned int cpu)
> +{
> +	struct rdt_ctrl_domain *domain, *tmp;
> +
> +	list_for_each_entry_safe(domain, tmp, &res->ctrl_domains, hdr.list) {
> +		if (!cpumask_test_cpu(cpu, &domain->hdr.cpu_mask))
> +			continue;
> +		cpumask_clear_cpu(cpu, &domain->hdr.cpu_mask);
> +		if (cpumask_empty(&domain->hdr.cpu_mask)) {
> +			resctrl_offline_ctrl_domain(res, domain);
> +			list_del(&domain->hdr.list);

(also related to switch to RCU list, remove domain from list before
starting to offline it)

> +			kfree(container_of(domain, struct cbqri_resctrl_dom,
> +					   resctrl_ctrl_dom));
> +		}
> +	}
> +}

How CPUs are associated with control domains are not clear to me. Above appears to
be consequence of how platform driver initializes so I will comment more there (patch #8).
Just for above, it is unexpected that a CPU needs to be tested against cpu_mask
of all control domains. Would a direct query that uses the CPU's cache ID not be
quicker? Also, above creates impression that a CPU may belong to multiple control
domains which should not happen.

> +
> +/*
> + * Remove a CPU from every domain it was attached to. The per-resource
> + * detach helpers act only when the CPU is set in a domain's mask, so this
> + * is idempotent and undoes a partial online attach as well as a full
> + * offline. Caller holds cbqri_domain_list_lock.
> + */
> +static void cbqri_detach_cpu_from_all_ctrls(unsigned int cpu)
> +{
> +	int rid;
> +
> +	lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
> +		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
> +
> +		if (!hw_res->ctrl)
> +			continue;
> +		cbqri_detach_cpu_from_ctrl_domains(&hw_res->resctrl_res, cpu);
> +	}
> +}
> +
> +/*
> + * Attach a CPU to every controller that claims it. On failure, detach the
> + * CPU from everything attached so far: the cpuhp core does not run this
> + * state's offline teardown when its startup fails, so a partial attach
> + * would otherwise leak into the domain cpu_masks. Caller holds
> + * cbqri_domain_list_lock.
> + */
> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +	struct cbqri_controller *ctrl;
> +	int err = 0;
> +
> +	lockdep_assert_held(&cbqri_domain_list_lock);
> +
> +	/*
> +	 * Hold cbqri_controllers_lock across the walk so a controller
> +	 * registered after boot cannot corrupt it. The register path takes
> +	 * it as a leaf and never cbqri_domain_list_lock, so this nesting
> +	 * cannot invert.
> +	 */
> +	guard(mutex)(&cbqri_controllers_lock);
> +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
> +			continue;
> +		if (!cpumask_test_cpu(cpu, &ctrl->cache.cpu_mask))
> +			continue;

What will happen if @cpu was offline when cbqri_capacity_probe() ran? From what
I can tell @cpu will not be in ctrl->cache.cpu_mask in this scenario?

> +		if (!ctrl->alloc_capable)
> +			continue;
> +
> +		err = cbqri_attach_cpu_to_cap_ctrl(ctrl, cpu);
> +		if (err) {
> +			cbqri_detach_cpu_from_all_ctrls(cpu);
> +			return err;
> +		}
> +	}
> +
> +	return err;
> +}
> +
Reinette

