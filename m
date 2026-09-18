Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12B362138
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692893; cv=fail; b=OvlhsNvmWBC9Fvt1OVswqtuECb+iJX5uDZv+491zrBlF/F/XagKH9H8ip/TROlrVsARTAOBnqAGKcEWCTe7ktolKW2EO2oqfj1TdI8XzDaPsWn2AxwYieSQLiWyn39VxPivSb0636lDPQa2Z8cxmr/bOAn52nG+XCkVEEKLRvGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692893; c=relaxed/simple;
	bh=49QcSF+z3EfyKcnpYSZBRI9LBnC81sVVMeTDhZH4i+Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MSutEksQj432WGWFoiGKr7IWFv0yKa7FOyX8lRiqjUMtGm+a7OujJTgfH1prG1i9SxETGqM58jvg9WQtTi++u2UG9xomJf4TBW5ieqvb5vyLIeZNOJnu2Vu3tHL0RX1uFd3PQoLlpm0vgAYAW/CAmUdGtiATLtIN1bNu1sQQcOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjf4JRYU; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjf4JRYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789692891; x=1821228891;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=49QcSF+z3EfyKcnpYSZBRI9LBnC81sVVMeTDhZH4i+Y=;
  b=mjf4JRYUWTxFtyj2Sh8rhzFn7okJvpGgFpqoBsD6khmuBh+tX75wuMra
   nAAISrElpFMUmkw+dN+FOkg1wd+UOBaPvVZvIpEJBEL6foM9Jbrw98H9r
   jNvIG7j9K3oQMQ98iVXqq9OI6jccN1mH5/XnEtVV/scennLXoWnhycIe6
   vCLv1//eSe4KN+uZPiijynzYdGMqhR8FfXL4tHfffLlEKw0gZqCKooc28
   kfRnuYUXY31niGhEYqAIjV7MRGwLNVEDEkZ9udDRx8isbSnULZUsgSfUA
   tqbuJarnRWF31F7N9HmiPcpPmIt+T82JGA7OSmLsfC1aMOTAzzTngES3Z
   Q==;
X-CSE-ConnectionGUID: gK+OBMSTTvapYKZICtFAFQ==
X-CSE-MsgGUID: cHOecYBBS224qWUsVAd2rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100830583"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100830583"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 17:54:50 -0700
X-CSE-ConnectionGUID: Xu7MWN0IQ4mkbJQT+iIyjQ==
X-CSE-MsgGUID: p+soBQe1SUKKiWNpeNjclw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 17:54:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 17:54:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 17:54:49 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 17:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KO2LgWnvMDoyyHijljIGUs1BQoC5Sgo6YmEnia591NSqHOd8v35y5WgLNbyiN6zcsIPckTaJ5bx5JTmTYzskIgYHgCGmINJg2GIQV0fwXZ17n9FxVW65en/xHQN0Yf7HXMuu2RHUwYeM2z6bIhdCL7/o2URbwTE9SoUhL87OpdjtbY+39k8Q6gYOb5fjZaXUBTlLU8pgGplxLj1Q9EIAPjEzuVZRnQ0p0KkBSkLXoz1i0sJ08eEmRbbhyaZrpJzDnk4AfLIhd1SKmkUho4u8do/7A0gwK4PeEeSBrbmOfDNIxcVG5svO2VZBdx1kkSt0x/SeJVvxu+WwwJixxG2xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erMFln3KimyaBzhYuW3dAa7AdM/JILWcYWuFRRA55mk=;
 b=arquwrtb710ZTC+Km38eiHlBAZWhPeWKkAzxILlt8hVskgjXdkRF4PemQRS1vNhjmnknnrpXMCmzvX5u4wH1XVvqEDwOYymK3mv6u/WawXxQYMFxZjCTqI21VpagU5ATKn5/x2mQ3ik+x5RW+EldP88iDmPIpqq41pFF3N0UbWgqNC+LSkb7tRZ5JF6SP+PCnWEVEljcb8hFscdsBvc+JepCFO9WU9hGybixr2FFEFoSsm0Be0I9vNhGgAyC/bLgaseTO9QEpaERV/xu1ndOTKfkbVg5Gnj4Kepck3pYFhCI3rqmgUXnB873Ogjr3CsNWFlZM9n/0HSRPjjyZZRUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by IA4PR11MB9060.namprd11.prod.outlook.com (2603:10b6:208:56d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 00:54:39 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 00:54:39 +0000
Message-ID: <fb4813cf-b21e-43ca-9bd4-4b42d2214aa6@intel.com>
Date: Thu, 17 Sep 2026 17:54:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Albert Ou
	<aou@eecs.berkeley.edu>, Atish Kumar Patra <atishp@rivosinc.com>, Atish Patra
	<atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, Ben Horgan
	<ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, Chen Pei
	<cp0613@linux.alibaba.com>, Conor Dooley <conor.dooley@microchip.com>, "Conor
 Dooley" <conor+dt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Dave Martin" <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>, Gong
 Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>,
	<guo.wenjia23@zte.com.cn>, James Morse <james.morse@arm.com>,
	=?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, <liu.qingtao2@zte.com.cn>, Liu Zhiwei
	<zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, "Paul
 Walmsley" <pjw@kernel.org>, Peter Newman <peternewman@google.com>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tony Luck
	<tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, "Ved
 Shanbhogue" <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, yunhui cui
	<cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <linux-doc@vger.kernel.org>
References: <20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org>
 <20260917-dfustini-atl-sc-cbqri-dt-v8-2-7964e8d73fe8@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260917-dfustini-atl-sc-cbqri-dt-v8-2-7964e8d73fe8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::26) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|IA4PR11MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f6cbcb-6145-45ef-33f3-08df151f6b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|921020|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: NOq2dRPHW1wIUL2FpH7yVCSUPIRtyexJiPfD1XXtqHrUmISAKkjznpjyaufYv7Chb2tY+JAP8ulGeu8OajrkCdjekPf1T9Q66Iprw3qLgYX4HE7Hw3xnrzVERpySUdAKlSZtA/7JqAPqvcnIHCr8soiXaBhk/GqQItsollE0TD1Ru1moJNsTu+9TKPw0lFpLyMtVPL2zfbtxb9+6LxTplPRgU+uXf3t0E8disg/AXkeoXT89K6OpBSFBoGeBKcm/7wXcyv0fhF79hE/LL5FI2KOmrIuHFdulaX83BSPI7xyUyV/+x7QmwzoJucR2I82lflOZuxoTl3Dp3wDE9WekMC8BINAsj8VdhKIzlipmS00t7zecp25yt6XH1uMAv2uwvKNw0estN7RcjZ6YO3sLgHV+kl4696qW3HYjnMYD9Jx4BeYzg6KVxMNuHjAGWigncq+cpd6iONFoECtH3Vs2XjbV3ZoY73c0ph0bPID5NapcE6wwYG2KBwdAG+MRCuI9XEyIkaMAoavorDciVmqiAqjt6J1muJSSdvEzj734sIb9HjMvc5ISic83OMnAacMEm8gIaHuXNwFukrDhyqofhOa+edB3ip4zorZfCu7I0TfLuu1v60eyUVNYk+dZr2KdHiXZQKRKNmtWberjuSdYCqnQtTsFxoNISgDUYiVY5bMCbkdWGAx5YUdtdCZieseMFyKCsgJnzQnqXZaeNI6mCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUFxRksyK29MUzE5ZHFrT2hNV0lWRVd3WUtEYUcydzFvYnRtNFNKOVhzbTQ5?=
 =?utf-8?B?SXh5SEhJb1NNSjh5ME1MVHVuMjJGOGtvbU9uTWtsNXY4SmJBWUsrZjBpdzdU?=
 =?utf-8?B?SGVqN1hjUXo2WVlzNEdYOHdtbWkvYjZpT01pZVZMTFlzcWxDRXF4clJ5RzR0?=
 =?utf-8?B?ZE5ieFA2WE5pd2ZqSzFyQ0h0M3piZXl1YlBObkhqdEpkbjRLSklHWnYzM1hX?=
 =?utf-8?B?VXZBK1VFa0FGdi9hblZxV0hpNGlPQlJ4RUtoTEtodmROaUtoQXZmeUxEcFll?=
 =?utf-8?B?OU5xaElpT2g5V0pkZWk4U2t2UGlkQk5QRWpoQmhKbG42MEwxVFlNS0RjVXhK?=
 =?utf-8?B?Mnd2ZnRFV3Q3MUp2dG1uMExFdGhqRzBwRHV1dlFHMnBSK0U1Zmk3OW1CS3c4?=
 =?utf-8?B?K3R1YlBlczg2UzZLWjdmN0hsK2dVUmRzZWVVU2VmN2Z3MXBRMC9KdTduT2I0?=
 =?utf-8?B?bEtjMkRjT0RPbGVaeVhraHpTZTFvK1VyaG9XZ0ZCTk9QRzZjSWxwZW5KL2d3?=
 =?utf-8?B?b2dCMUo2N1dVUVlGZWZMQnRjL3hsSlFJK0VlN1RtLytFdU9QOVZibGdKbUM1?=
 =?utf-8?B?R3Y0azQwOWFPZUZudjRJM0M2ejFHS0czekF0Y0srVHF2TnZTdVIrd2pUZ0tM?=
 =?utf-8?B?ekZxV3pLaUJNbDhhNzNRTkxwZzVjbkdOdCs4bXhPUkZ2aWk2RkxXOWZvNkpE?=
 =?utf-8?B?VCt1U1V4Q1BQZ3lJS2tLYnh3WE1wK3IwcGkrY1VLUnZOTStqQ3FHOVArcVVk?=
 =?utf-8?B?SG9tUDdnczQ3bFMreUErMVREZ05IQkxNN2dwL3Y0UklGdGJCSmJ4MzRyUEcv?=
 =?utf-8?B?TGdUaEpCZXZvVXB5OElZQWZreWRHdXRjMUd5dGZkNzAwWFpWNFpwSzhmUGdz?=
 =?utf-8?B?cFZwai8zMFNoUDlxVFhENkg1c25MeTErUUlKbXV6OEM4dzdsVjNLT1Bka1Ni?=
 =?utf-8?B?YThoRHlGV05kYjdZcDJISE5Ta2RLcXFmWGhCVTdJSWY4cmZVSDM1bmJlS0g2?=
 =?utf-8?B?TFBNOXRBSEF3ZjNaMUFCamdqM1cxakt1R0dKdnNkRlI2WkFOMm84ZmJqcTMx?=
 =?utf-8?B?T3c5cWFLWEtxd1g0a2pZUDJNeHgrN3Bndm1qcXZ3S3RjUnVLenRqRDZYdFJh?=
 =?utf-8?B?VkxPWlVSOC9yVEEzRExndk8wcVMzYmxSSitSMFFXUmZMblA5eEpieXZvZzJq?=
 =?utf-8?B?UzROK2F2UFQvM0JLMmpuRTF0OUhmTUFKSjB0dlg0TXgvMitBT09USmU2SVE2?=
 =?utf-8?B?VnNlYksxUHpiVGNGMmNBbW1yVFU2SVZLbjd0TnBLeWlPSjdGU2Vxenp6ejJj?=
 =?utf-8?B?amlPcFpjcHZQRHJSYlovT0FURDVnVDRXeHMvQmRkOVIxZGpZTVJzZmIwMng4?=
 =?utf-8?B?b3Q1dlBodktJSmtNQlBsRWtRZklsQ2htZmUyZUFpY1U5SDA0a1c3RnNjK0M3?=
 =?utf-8?B?VmtLeHYwSG9EQWN6WU04ZGpSU2l5SXlGV1BKYVRod2tObWV1cUREZmtxUVdy?=
 =?utf-8?B?eitxaFVuclg5ZTRHVHNHSmFVN2J1eEtQd1lKVkFBU0xXUXRsN05OenNWZWRh?=
 =?utf-8?B?YlBMdmNQWWh0R1Y1WG5ZemlEOXJla3JEOFc0dG5Ic29SMzdwelR3THRQck1U?=
 =?utf-8?B?K3NCZFRBcmhnWDU5QmFWMlNJZmdNUi9SYW5iOXZLaDJqQWl4RGVXU3c5OTdD?=
 =?utf-8?B?V3hxcW9ZeHAvc1liTTVWT0xybTN1aG9GTWpEZ0s0a000dzRjc3FyWDQrVGln?=
 =?utf-8?B?RTZ6L050MWRXZGpIb2Q2cHhsUzNZcGcxRndlV2ZST1hIZS9BdjQ2M1ZRcXk4?=
 =?utf-8?B?Z25yd3NJem51aXl6aDRLRFU4Ukp5aTdzRXdsZHBPWVE1dmRIYnNWSnR1bGdJ?=
 =?utf-8?B?bGQwLy90UGxOS0l6dGV5TnBmUWwwb2RvMmVOTnI3bkkvdmtMcVRrd1FMMzhu?=
 =?utf-8?B?NVY0SDhLTzRMWlMvSnJrS202Vzhma2dHZUdmUys0bDhWeU9aNDZmMWdzU05W?=
 =?utf-8?B?d1NKVmU5UEdyamJkcHR4cXlzTmIrOGY1Vmp3N1I5YmMwenB3YjgzaTN5c0tD?=
 =?utf-8?B?a2Vkenh6dDBJdmFrTU1ZUHJCS3lDekpVTDFLdEY4ekxoeHViUmRhLytkRGRa?=
 =?utf-8?B?TmxWQXdnckVuZDNtcjlhZkRKbkVDaE4yWk9PbENPcDBZalIyR2JQemEwbFNF?=
 =?utf-8?B?Z0RqaFY2cnVrNHpkSHpTR2hsbjZNZzRKRUNsVDdHWkowODArOXBLWXY0c3dF?=
 =?utf-8?B?VUY0ZExYWnNVZlVNWnl1eHkycmJ2L2FoSk9NN3FkWkVKSXdSVFhjVG1IV2xj?=
 =?utf-8?B?aDNxR2hFNyt5cWdid25WQS9PbXV5WW1meUtKd1B6YWRCZzVTaWxEY0hUNjB2?=
 =?utf-8?Q?+QyCtUAxIjUzZa6c=3D?=
X-Exchange-RoutingPolicyChecked: 2V3m1mj82MheBkyTNsOTpAgf2Gn9Yox3Bc7aAmLvM5dLv6L+BLfG0kROj/o2KLK5RNs8OW/1etiuDlobIyx29c2JNbS9Z5fTtOmLXcSDWT5rcVL3vuRe59xc6vEWJ4Zu01fSDSsfw10MYZbiWiAWZs0+iMDkz1RptuzqAPP1l62vCxs2l73FZ+wo2dGZgHuy7n/G04Hpj3r6J305ARk3mCHqvLkeG+zPv8YkQp78SgNqd3vyEVywEXB8WRvOSltAZsS+RtP8a1EVPSc5ESTk999S/Qdzza3rg3N0O38Suoj3Fv0AXSlCXjO85iH/B6TaTCrKq0cfOIdiX/4AKtsV3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f6cbcb-6145-45ef-33f3-08df151f6b23
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 00:54:39.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +F9aMEKQ02siLLkxwcgwzEf2mYhGanSqzKVIrBXx0j8e545oCNsi/IKABJXcuEy8BbHgXS0h7e0FYoh1cQWkFZOAc0jSQVacJgG0Y2vIOBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9060
X-OriginatorOrg: intel.com

Hi Drew,

On 9/17/26 9:39 AM, Drew Fustini wrote:
> diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/resctrl.h
> new file mode 100644
> index 000000000000..b08f4e12f7aa
> --- /dev/null
> +++ b/arch/riscv/include/asm/resctrl.h

...

> +/**
> + * resctrl_arch_alloc_capable() - any CBQRI controller exposes resctrl alloc
> + *
> + * Returns true once at least one CBQRI controller has successfully probed for
> + * a resctrl-exposed cache capacity allocation feature. Only meaningful after
> + * cbqri_resctrl_setup() runs at late_initcall.
> + */
> +bool resctrl_arch_alloc_capable(void);
> +
> +/**
> + * resctrl_arch_mon_capable() - any CBQRI controller exposes resctrl monitoring
> + *
> + * The CBQRI driver implements capacity allocation only and wires up no
> + * monitoring events, so this always returns false. fs/resctrl references it
> + * unconditionally, hence the stub.
> + */
> +bool resctrl_arch_mon_capable(void);
> +

fyi ... I aim to comment more details later in this patch but for now please note that
there are plans to remove the above two hooks since resctrl self has needed
information via the rdt_resource::alloc_capable and rdt_resource::mon_capable flags.

For reference:
	https://lore.kernel.org/lkml/20260916231320.14502-7-tony.luck@intel.com/

I see this has impact on this driver that I comment more below.

...

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
> new file mode 100644
> index 000000000000..0c4bfa2a7f43
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c
> @@ -0,0 +1,785 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
> +
> +#include <linux/bitfield.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/cleanup.h>
> +#include <linux/riscv_cbqri.h>

Just an observation (I have no intention to comment on the style):
The new c files in this series seem to make an effort to have the #include
files organized alphabetically, except when if comes to the file above?

> +#include <linux/cpu.h>
> +#include <linux/cpufeature.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/rculist.h>
> +#include <linux/resctrl.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include <asm/csr.h>
> +#include <asm/qos.h>
> +
> +#include "cbqri_internal.h"
> +
> +struct cbqri_resctrl_res {
> +	struct cbqri_controller *ctrl;
> +	struct rdt_resource     resctrl_res;
> +	bool                    cdp_enabled;
> +};
> +
> +struct cbqri_resctrl_dom {
> +	struct rdt_ctrl_domain  resctrl_ctrl_dom;
> +	struct cbqri_controller *hw_ctrl;
> +};

Is cbqri_resctrl_dom::hw_ctrl necessary? From what I can tell it is
initialized from cbqri_resctrl_res::ctrl when a new domain is created
and thus identical in all domains that belong to a resource. 

It looks to me as though the resource is always available when the associated
controller information is needed so it looks like just cbqri_resctrl_res::ctrl
could do?

The way the data is organized results in potentially confusing code since, for
example, when initializing the control values of a single domain
(cbqri_init_domain_ctrlval()) the RCID count is obtained from the domain's
cbqri_resctrl_dom::hw_ctrl::rcid_count but when initializing the control values of
all domains (resctrl_arch_reset_all_ctrls()) the RCID count is obtained from the
resource's cbqri_resctrl_res::ctrl::rcid_count instead of each domain's domain
cbqri_resctrl_dom::hw_ctrl::rcid_count.

> +
> +static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
> +
> +static bool exposed_alloc_capable;
> +
> +/* Protects ctrl_domain list mutations across CPU hotplug. */
> +static DEFINE_MUTEX(cbqri_domain_list_lock);
> +
> +static struct rdt_ctrl_domain *
> +cbqri_find_ctrl_domain(struct list_head *h, int id)
> +{
> +	struct rdt_domain_hdr *hdr = resctrl_find_domain(h, id, NULL);
> +
> +	return hdr ? container_of(hdr, struct rdt_ctrl_domain, hdr) : NULL;
> +}
> +

...

> +
> +bool resctrl_arch_alloc_capable(void)
> +{
> +	return exposed_alloc_capable;
> +}
> +

...

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

Since it captures whether any of the resources are alloc_capable it looks like
exposed_alloc_capable indeed reflects the same information as what resctrl will
use after resctrl_arch_alloc_capable() is dropped (see patch linked earlier).
Except that cbqri_resctrl_teardown() only resets exposed_alloc_capable but not
the rdt_resource::mon_capable and rdt_resource::alloc_capable flags that the new
helper will use to determine if a resource is capable of allocation or monitoring.

The new helper will thus change behavior. It looks like resctrl_exit() is only
called on error path during initialization so it seems unlikely that those flags
will be referenced by this driver.

If there are plans to call resctrl_exit() in other paths like MPAM driver does there
may be issues since the resctrl filesystem may still be mounted and when user space
unmounts it the rdt_resource::mon_capable and rdt_resource::alloc_capable will be
used and result in some arch callbacks called.

I wonder if it may simplify driver initialization to call resctrl_init() _after_
setting up the CPU online/offline handlers (this is how the x86 driver does it).

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
> +	domain->hdr.rid = res->rid;
> +
> +	err = cbqri_init_domain_ctrlval(res, domain);
> +	if (err)
> +		goto free;
> +
> +	err = resctrl_online_ctrl_domain(res, domain);
> +	if (err)
> +		goto free;
> +
> +	/*
> +	 * Publish only after the domain is fully initialized and online, so a
> +	 * reader walking the RCU list never sees a half-built domain.
> +	 */
> +	resctrl_find_domain(&res->ctrl_domains, dom_id, &pos);

The caller loops over the domain list to determine whether it needs to create
a new domain or not and then this domain create code loops over the list again
to determine where to insert the new domain. Could this perhaps be simplified if
the first loop  cbqri_attach_cpu_to_all_ctrls()->cbqri_find_ctrl_domain() determines
the position at the same time as determining the presence and pass that to
this function to just do the insert without searching the list again?

> +	list_add_tail_rcu(&domain->hdr.list, pos);
> +
> +	return domain;
> +free:
> +	kfree(container_of(domain, struct cbqri_resctrl_dom, resctrl_ctrl_dom));
> +	return ERR_PTR(err);
> +}

...

> +/*
> + * Attach a CPU to the capacity controller at each cache level whose cache
> + * the CPU shares. On failure, detach the CPU from everything attached so
> + * far: the cpuhp core does not run this state's offline teardown when its
> + * startup fails, so a partial attach would otherwise leak into the domain
> + * cpu_masks. Caller holds cbqri_domain_list_lock.
> + */
> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
> +{
> +	static const u32 levels[] = { 2, 3 };
> +	struct cbqri_controller *ctrl, *c;
> +	struct cbqri_resctrl_res *hw_res;
> +	struct rdt_ctrl_domain *d;
> +	struct cacheinfo *ci;
> +	int i, rid;
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
> +
> +	for (i = 0; i < ARRAY_SIZE(levels); i++) {
> +		ci = get_cpu_cacheinfo_level(cpu, levels[i]);
> +		if (!ci)
> +			continue;
> +
> +		rid = cbqri_cache_level_to_rid(levels[i]);
> +		hw_res = &cbqri_resctrl_resources[rid];
> +		if (!hw_res->ctrl)
> +			continue;
> +
> +		/* The controller backing this CPU's cache at this level. */
> +		ctrl = NULL;
> +		list_for_each_entry(c, &cbqri_controllers, list) {
> +			if (c->type == CBQRI_CONTROLLER_TYPE_CAPACITY &&> +			    c->alloc_capable &&
> +			    c->cache.cache_level == levels[i] &&
> +			    c->cache.cache_id == ci->id) {
> +				ctrl = c;
> +				break;

Is it necessary to loop over cbqri_controllers and repeat these tests? Above seems to
duplicate the work done during initialization (cbqri_resctrl_pick_caches()) that resulted
in initialization of cbqri_resctrl_res::ctrl so it seems that after testing for existence
this function could just use cbqri_resctrl_res::ctrl without again referencing cbqri_controllers?

If I understand correctly it may be that new controllers appear in cbqri_controllers 
after this driver is initialized and the resources are initialized so the CPU online/offline
helpers may need to take care how any controllers in cbqri_controllers not seen by
cbqri_resctrl_setup() are handled.

> +			}
> +		}
> +		if (!ctrl)
> +			continue;
> +
> +		d = cbqri_find_ctrl_domain(&hw_res->resctrl_res.ctrl_domains,
> +					   ci->id);
> +		if (d) {
> +			cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +			continue;
> +		}
> +
> +		d = cbqri_create_ctrl_domain(ctrl, &hw_res->resctrl_res, cpu,
> +					     ci->id);
> +		if (IS_ERR(d)) {
> +			cbqri_detach_cpu_from_all_ctrls(cpu);
> +			return PTR_ERR(d);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static bool cbqri_resctrl_inited;
> +
> +static void cbqri_resctrl_teardown(void)
> +{
> +	int rid;
> +
> +	if (!cbqri_resctrl_inited)
> +		return;
> +
> +	resctrl_exit();
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
> +		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
> +
> +		hw_res->ctrl = NULL;
> +		hw_res->cdp_enabled = false;
> +	}
> +	exposed_alloc_capable = false;
> +	cbqri_resctrl_inited = false;
> +}
> +
> +static int cbqri_resctrl_setup(void)
> +{
> +	int rid;
> +	int err;
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++)
> +		cbqri_resctrl_resources[rid].resctrl_res.rid = rid;
> +
> +	cbqri_resctrl_pick_caches();
> +
> +	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++)
> +		cbqri_resctrl_control_init(&cbqri_resctrl_resources[rid]);
> +
> +	cbqri_resctrl_accumulate_caps();
> +
> +	if (!exposed_alloc_capable) {
> +		pr_debug("no resctrl-capable CBQRI controllers found\n");
> +		return -ENODEV;
> +	}
> +
> +	err = resctrl_init();
> +	if (err)
> +		return err;
> +
> +	cbqri_resctrl_inited = true;
> +	return 0;
> +}
> +
> +static int cbqri_resctrl_online_cpu(unsigned int cpu)
> +{
> +	int err;
> +
> +	mutex_lock(&cbqri_domain_list_lock);
> +	err = cbqri_attach_cpu_to_all_ctrls(cpu);
> +	mutex_unlock(&cbqri_domain_list_lock);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Seed the per-CPU default RCID/MCID to the reserved (0, 0) pair and
> +	 * notify the resctrl core so it tracks this CPU in the default group.
> +	 */
> +	resctrl_arch_set_cpu_default_closid_rmid(cpu, 0, 0);
> +	resctrl_online_cpu(cpu);
> +	return 0;
> +}
> +
> +static int cbqri_resctrl_offline_cpu(unsigned int cpu)
> +{
> +	resctrl_offline_cpu(cpu);
> +
> +	mutex_lock(&cbqri_domain_list_lock);
> +	cbqri_detach_cpu_from_all_ctrls(cpu);
> +	mutex_unlock(&cbqri_domain_list_lock);
> +	return 0;
> +}
> +
> +static int __init cbqri_arch_late_init(void)
> +{
> +	int err;
> +
> +	if (!riscv_isa_extension_available(NULL, SSQOSID))
> +		return -ENODEV;
> +
> +	err = cbqri_resctrl_setup();
> +	if (err)
> +		return err;
> +
> +	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cbqri:online",
> +				cbqri_resctrl_online_cpu,
> +				cbqri_resctrl_offline_cpu);
> +	if (err < 0) {
> +		cbqri_resctrl_teardown();

cbqri_resctrl_teardown() calls resctrl_exit() that will complain
via WARN_ON_ONCE() if any domains exist at that time. It is not clear
to me if this can be guaranteed here.

> +		return err;
> +	}
> +
> +	return 0;
> +}
> +late_initcall(cbqri_arch_late_init);
> 

Reinette
