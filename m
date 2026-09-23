Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DA54281F
	for <linux-rt-devel@lists.linux.dev>; Wed, 23 Sep 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180517; cv=fail; b=YQ0TBeIQnCk5wIYFAvqsBTtO1b5GDcdo7/DukvGDF5YKHQ9IYOb4wy0BJbnfnezr1mLAD7fAejGgX+aqgWWF8Nzck/IIOjyVNBfTlZdC2HqNtU+oJ0e5rkWKCvFRraVHmH4pNG/k3RtfHi047aj3R5EhWlmjgQyA33OwDSlYC/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180517; c=relaxed/simple;
	bh=7vyEZYUAdfP8El466kRpnHdXncIbHkNpzjAO6D52z8k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hGC4puKvJfGUzXsl94b6mdt7E2Un29e+JPXRtYYfX12s9hxkX0sKcBi3+7kM40ghBuA5zMreAMxcGfSP4qeDuhs+cOfFstgfgWqtZiga1PqHwrLrwwVM1pxh97ScXxF1RoQuGhxMebU76YNY5kzc6s8r78SyssO3Hqaaly8o8d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzHgY2Ey; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzHgY2Ey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790180514; x=1821716514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7vyEZYUAdfP8El466kRpnHdXncIbHkNpzjAO6D52z8k=;
  b=MzHgY2EyproFUYVLmAc7mQhZUPAKMUYgFQ5O7YxsRBdTgWwQzFODFPcO
   OrHdVs2+8vppEGFnxRy0RTZW6VLfrqerlenBcQJai8smQ0ZG8JyFCNx5A
   NqjhWPIKiB4ryBUXbeewpLUJnHgZkzFa9GYsS4leLr0XaGPQvXHg/0wQC
   iYwj8GboiGBW63LYaoB+VXug2dOv0AUxygjBx0CL5B4tmtV1IgLhfCKB2
   MA3Zy7c08W+r295EsELveUSzmwgkHmKPZgm3FT1Ka/x4zhdyMiWtsR0hL
   22S77pxnuMhwji87XXPjkVfdL9bKQ60DHA8cJlRkuOHeAx+sSO6aLa+Jj
   g==;
X-CSE-ConnectionGUID: BFG03Tf3QIqg6NeLhwHa1Q==
X-CSE-MsgGUID: dpVV854FQhmNOnTcX6TfUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1390024"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1390024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:21:53 -0700
X-CSE-ConnectionGUID: QgsPguEYQTuuNNSP5O1dgw==
X-CSE-MsgGUID: o09b3t8IQfyedUHh+qIoSg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 09:21:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:21:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 09:21:50 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 09:21:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gbm/eqZhQTmoDBXAXkhQqhPsn9o0q3b7R6t7eQe4kqZV9rEmRAlhD2eGFrmNBpnB31BXAboIiOnAlas5ewdlViNNaAl2Wj7XXQhinLB37RQkI8pvyxduji7GX1Al6WbAChL+mZ6svVWuzqB6bDfvBCG/IvFYZOsnb0UAlwwZPXY4wIzxj7EDVvrfKFd/Lq9eEp5DVTRypbAdINO8ouBph/xHo+mRJ3d81akZ2TPS2afCz0vm5Av0hRb2v0hnHGQ3G9O/k5ZqlH4L9p/wgkoOLDgcm/1lUZQF/MwaAA468Vhj5lbKEpMsBqrjkJFOQxKKfC+VxUHG4gC3X0rovL4cpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xitU+p0+uSm4e4mLJ8FxdsliLoTRR1Qa6kucEU3UQeI=;
 b=R2mwOvWV6r9FxJOVQXhfLpnjs29C8Z4KUTgxH3T6GO70k798clYr36T3MA4wkEgK7HRLU+gOLslH7i+z+qTIRF7UZ077rFS5cFzXyDhx9HjDY07D4o4C/VSCJJhby1Fo0VCE/vDiepjcwShWEThJkiOaiLo8luFGIYj5oKOeiTmBUFXFl8zIsiOBl1w9BmX0F6szPv2P3gcZYUZsL887yTJ7CZl8Iul+PADkp5oI4/nQ6kl5Y/bWMWL6FQnAOwlbgyRNF6JhztpkzNIlN2wBLteUB3gB8xMk5d3lW904rGMc/tw00aIRiHyX6KgNRrDZwKenchleGhzRpin1oFWdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20)
 by LV4PPF9BE730F55.namprd11.prod.outlook.com (2603:10b6:40f:fc02::22a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 16:21:48 +0000
Received: from IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6]) by IA0PR11MB8379.namprd11.prod.outlook.com
 ([fe80::549f:e4b3:e10d:aaa6%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:21:48 +0000
Message-ID: <5479ef44-64f9-4c98-9b69-82a82c1cb33b@intel.com>
Date: Wed, 23 Sep 2026 09:21:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: Drew Fustini <fustini@kernel.org>
CC: Adrien Ricciardi <aricciardi@baylibre.com>, Alexandre Ghiti
	<alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, Atish Kumar Patra
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
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tony Luck
	<tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, "Ved
 Shanbhogue" <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, yunhui cui
	<cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <x86@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<linux-doc@vger.kernel.org>
References: <20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org>
 <20260917-dfustini-atl-sc-cbqri-dt-v8-2-7964e8d73fe8@kernel.org>
 <fb4813cf-b21e-43ca-9bd4-4b42d2214aa6@intel.com> <arIm5yXDZhkH3KLm@thelio>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <arIm5yXDZhkH3KLm@thelio>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:303:8c::6) To IA0PR11MB8379.namprd11.prod.outlook.com
 (2603:10b6:208:488::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8379:EE_|LV4PPF9BE730F55:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b3e2e6-aebc-43c3-2e47-08df198ec457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|4143699003|6133799003|22082099003|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: xKxnyfv+qfvCcZ3ZxtH+AxMuR6TybGLbUg8kIkDY1B1l8ZaCJA4JLeB6Aly8EflS8tljSiVWxGlKFF28rvHilMM3YG3xHBRDvWu4nImBdXTm4R9njTmDuSBDg0sSSlS0Bq6ZHBXT++IiLLxFP2Tu5fsLiTRb+6PkY3REk8uSqg3t9SM4LDM0z+wxrU+lfiMIIcwGSwnMLvlgaDm7r7lwzay6ikGFtZpzNOHn7nAI9Cu3XRHHQHW05OLe8Mh9ZOcc13ndk2ir4UneKeSNEHycwdk5geapJfdcoZorkH5eG1C9x1yWyz9um8Kg6yniNDTg/uVW3N1Kj2KtGolQzLTjXdRoe0L8WVM/hAjW9YHBomwBPpaCUDRbFsA/8t+MWEjgEGFYPglsaRiLIL2Iax6ZtkY8mLPNF7rzafkEAv4Ju9jITmeXp3oXBA0EmBvK/xFl4gs4AsJoAoz+qdeFsiGvHriK/rxIaX2BPJn/dGBjYC6n/qcZFK2VtPT/JFyKQVfCd7ex6XZ6i3LHwAwpzt+/pjfnvrHvYsQg/63ollMR2ZfYuNCeEQca91hGYufUrRg0m+Ia7mo9HkTMq3jDQdcIB5/+mdIev61/nftPO+wx6bxgd7XFaoeitgUw3jOIfo7lgDRvJnSFsKJ/vM1Qz/rKwNzAJU2jTfA23gQxpWsPnIE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8379.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUE3dWpvaWIrUUZ2dHFLdk5kVUFGbmlFN0dmb3BaZVFFM2s1WmwzbHNhVDhK?=
 =?utf-8?B?cithN0JDTnNBY3lYTkNYVXE3TXVOazEyVFpQY3dScGxpNGxUTXMrek1HWmFR?=
 =?utf-8?B?aER6QkZDM01BaFRmWWY0NXk0Q1JHYUowdGRKMnFZWURBVGluMFdzcXBqc2gz?=
 =?utf-8?B?VW9xRVp4emxWWWJnakRqaVJGNmh6a2VWb3pPMzlvb1gzRXd3VFdERFZwbGI2?=
 =?utf-8?B?Wk9NZHhvTTdBb0h0dzFzc1lUSlo5ZWY2d2Y4ZCtzRE1XV2c0ZjM1d0UvSC83?=
 =?utf-8?B?ZXp4SlpNL2VzbEtDWklYUDhTd1h3ZnpodVRoWEcxUytsaS9ITncrdC9ONERF?=
 =?utf-8?B?OFd5NTdUQjRwUjJPR3lVL1ZnK3FYUkpPTG5sMDdYTnRWZUdnMzlWUGpDelJ6?=
 =?utf-8?B?K3YyYjhsbTFTV2s3aTJxRy9zNkRuZFpHam9OcE9aWmFjeVUxMi9JQm5OclNF?=
 =?utf-8?B?VE5mOEtrVkEwcUh2aDFWVjFlemV1SGQ4MXl2TnBrRmxDeUpDRE5YRkFHMXJB?=
 =?utf-8?B?cUR1TUNVY2xCQVpJV1lWUU5LSHZEN00xSW1ZelJ5ZGtxQTdIWEwzTEFETHhV?=
 =?utf-8?B?Q3lML0htYzZFZEdSM1dLM3QyclZnazJXSnpKZFRNMGxTNGd0cG9zWUxJMjZY?=
 =?utf-8?B?NW82QlR4WUtCMnFKWFV3d0ZYd2dJWktONlVweFQrL2hlWDJQWWJMWG15UCs2?=
 =?utf-8?B?Zkp1dzgwVnczc1dwMGI1NmcwZGVYWVFmOTVFdURkcXBsZE8wdDF4MU42aWZW?=
 =?utf-8?B?SVhkN0tUdWczUmtFWnhqZzkwTkxLYVpBdTN3bkRITWZTbzRadnVJYVFpSW1i?=
 =?utf-8?B?K0VvWUtYNXRMYm9SbWM2Z2wzUVJrNUt3Si8rNTFjc1ZyU1dxQ1hUa1hzeXh4?=
 =?utf-8?B?ZjVOQWhIeG9SOExTS0FkSGRLK1dtM1U2cUdIOURQOExlZmZzYUZGcEtsQ0c1?=
 =?utf-8?B?aEZ6SDVYYmxTd25NcWgwaHY4K3N3NllHWm5PS2pmTGtWOUhRZitSd0U2TkVw?=
 =?utf-8?B?eWNySytqS3hyZThlK3pBZ0FidHdXYXpreVVSYkVZNjk0MFlQWXlVSWp4ZlhD?=
 =?utf-8?B?bDFocDk5a3F0REFaWGU0dlJuaHBmWkJ1MUd5K05sMzRpTEdSWVd4QXI4TnMv?=
 =?utf-8?B?NmxUVTR3alp0MjI5Z09WUmwwWFE4dFVUTjVVYmIzeHdkbE9LVW5YRDFvTTc1?=
 =?utf-8?B?ak9hbmQvUjRlbGFURitRTTB2RDFNZXFTUTh6K3ZpTVIweEs3dk5hNlZxVjNr?=
 =?utf-8?B?QlkzZExGcGI0d0FWVjE0TVJ0eVFuN0hKQU9GWnk3TUZXcC9MY2Y0S1VmYkpi?=
 =?utf-8?B?RjQwU1J4ck45L1A1aDhkTTQ5aXZlZk9JRWNkRnFHNVZEQ2g4YWF1U0xyczJl?=
 =?utf-8?B?a0l3VzUyWW44SVAxa2hHaFQ4OGhMbXFVV3JqL2VLN1luSmV1aklzWUNDVEJm?=
 =?utf-8?B?bHUzM2pMWksvRWZ6ZzZtWk81NFJTMWw3RHR6cCtxWUhpYU5nQ0hRQW1NVFBW?=
 =?utf-8?B?WENlUkNIcU0xdTBQTG5oK2xGSmYrU3dyVFE1SFlxd1FFaHhnT1IwWTFrWlhk?=
 =?utf-8?B?T0FiQzQ4MmNGMUY2cVg2WmV6OUJxMkljbzR2eTY4TVZMSzZtL2R0SDhZMGw4?=
 =?utf-8?B?eTFqcjZlenBDR3VySVdXQUMrWGhWOVdhYlVqaWkyeDI0em5zYnAydk9hQjda?=
 =?utf-8?B?MFlUQmp1RC93UU12MDhiR1hvaWtrb1phTGtoditTU3EyRHFHQWFVTEY5SkNt?=
 =?utf-8?B?QXNtZXlUek4yRnZHbUVsdzdnNERKaW5MMWNua1phTGNNRzVtOGRBZ25DT3FK?=
 =?utf-8?B?Nk03V1k5eUdONWVnRU55SVdvUTQzVk5uTDBtdU9wSjVja21QTXJjL2dHL0hW?=
 =?utf-8?B?M2N5V2lGSWhsVjlLSFIrVmJ3N1lLLzBhTGU0c0llUmFLeTFoQ0I1aXBzUE40?=
 =?utf-8?B?c0s3Z3QvTXM3KzQyUE5oSEVSVXJJZzEydS8yVU1pVWV3Tk5ra0VLV0YrT000?=
 =?utf-8?B?N2hYbWpCKzRJMnFMM1l1bkhFbzRPMFc5bXk1UDJqdXpoM1lydVJ6Vi9RTE85?=
 =?utf-8?B?akdDeFBJTWdvTHlYQ2ZLYmxYQmtTT0ppWEsyMlFsejJqN01aR2gvNE43aG1w?=
 =?utf-8?B?eGFnMVlXdFlZT2JtbFJjVU41MWxlc09WREVMSnRDRWl4YUMxRG9ocWxTWm5i?=
 =?utf-8?B?OXZtenE2WmpLbmJVVzZ2Z0ttYjN2ZElYdmtvaTNKOHgrNXR5bzUrOHFOL2lC?=
 =?utf-8?B?WFNPZ3dENEljbFNpWC91S1BKYmhFaklOSUtWc3ZDUk82YmtzZmNHTVl2eVp4?=
 =?utf-8?B?VVh5akxBQzliMWhqNFV3bWtPM0pmZGtqWXlOaE95MytLYUVOMVNReDlWN3FP?=
 =?utf-8?Q?Otp/S0ZztXeDgDEw=3D?=
X-Exchange-RoutingPolicyChecked: NCNxYvLS54JshDQxTQvrL5k9W5b2oq0Nz8opf3Pk9A1f/chp7Xx3ZuBrSpqcm9Iyi+8BZd6FguWynP+MFUnrBQhlsiwW/o2TXf2TzER3vDdtCq9854ytVVwtG2smDHuyuBO24gLk5TWyR8HzfkdMRt/lrUo3vP7Qbw2VphFAyzNRTZrGBbm/2ugizdF15PVs+YgZ7vjdhs/eLaA7XzUVKpFL/As/diYMMrJ7RWwBaZhwjqMvs6+HSNl/BaGoayJ7RgwJRAGBhTgcL2eylne73H4hHwp2VQC/FK8Ps/zMsDlq3dEqdbhwIGH9hF4/nmT/QtsG3swEFU8eSOeY/Sg9Mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b3e2e6-aebc-43c3-2e47-08df198ec457
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8379.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:21:48.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+GyMFpI1HvhSADjeNOF/q8JdWIM1/5DfgWTtIh6AMrM7wzegtHQTrjXTAn7KHTe8U+Zin/eVIfBbxt2Zmtc+fw71Z+wziabSERreH2gdA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PPF9BE730F55
X-OriginatorOrg: intel.com

Hi Drew,

On 9/21/26 11:57 PM, Drew Fustini wrote:
> On Thu, Sep 17, 2026 at 05:54:35PM -0700, Reinette Chatre wrote:
>> On 9/17/26 9:39 AM, Drew Fustini wrote:
>>> diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/resctrl.h
>>> new file mode 100644
>>> index 000000000000..b08f4e12f7aa
>>> --- /dev/null
>>> +++ b/arch/riscv/include/asm/resctrl.h
>>
>> ...
>>
>>> +/**
>>> + * resctrl_arch_alloc_capable() - any CBQRI controller exposes resctrl alloc
>>> + *
>>> + * Returns true once at least one CBQRI controller has successfully probed for
>>> + * a resctrl-exposed cache capacity allocation feature. Only meaningful after
>>> + * cbqri_resctrl_setup() runs at late_initcall.
>>> + */
>>> +bool resctrl_arch_alloc_capable(void);
>>> +
>>> +/**
>>> + * resctrl_arch_mon_capable() - any CBQRI controller exposes resctrl monitoring
>>> + *
>>> + * The CBQRI driver implements capacity allocation only and wires up no
>>> + * monitoring events, so this always returns false. fs/resctrl references it
>>> + * unconditionally, hence the stub.
>>> + */
>>> +bool resctrl_arch_mon_capable(void);
>>> +
>>
>> fyi ... I aim to comment more details later in this patch but for now please note that
>> there are plans to remove the above two hooks since resctrl self has needed
>> information via the rdt_resource::alloc_capable and rdt_resource::mon_capable flags.
>>
>> For reference:
>> 	https://lore.kernel.org/lkml/20260916231320.14502-7-tony.luck@intel.com/
>>
>> I see this has impact on this driver that I comment more below.
> 
> Thanks for letting me know. cbqri_resctrl_control_init() already sets
> rdt_resource::alloc_capable, so I will drop exposed_alloc_capable. I
> will have cbqri_resctrl_teardown() clear rdt_resource::alloc_capable.
> 
> Should I wait to drop the hook until Tony's series is applied?

I do not think there is a choice here since resctrl fs will keep expecting
the architectural hook until that series lands. We'll have to coordinate
the inclusion of these two series around this change. If this series is
merged first then I expect Tony's series to include removal of RISC-V's
resctrl_arch_{alloc,mon}_capable(). This should be simplified thanks to
the clearing of rdt_resource::alloc_capable. 

...

>>> +struct cbqri_resctrl_res {
>>> +	struct cbqri_controller *ctrl;
>>> +	struct rdt_resource     resctrl_res;
>>> +	bool                    cdp_enabled;
>>> +};
>>> +
>>> +struct cbqri_resctrl_dom {
>>> +	struct rdt_ctrl_domain  resctrl_ctrl_dom;
>>> +	struct cbqri_controller *hw_ctrl;
>>> +};
>>
>> Is cbqri_resctrl_dom::hw_ctrl necessary? From what I can tell it is
>> initialized from cbqri_resctrl_res::ctrl when a new domain is created
>> and thus identical in all domains that belong to a resource. 
>>
>> It looks to me as though the resource is always available when the associated
>> controller information is needed so it looks like just cbqri_resctrl_res::ctrl
>> could do?
> 
> cbqri_resctrl_dom::hw_ctrl is needed when a cache level has more than
> one controller. Each cache instance has its own register block, so a
> domain has to reach its own controller.

ah - I missed this. Thank you. Your later explanation of my same misunderstanding in
cbqri_attach_cpu_to_all_ctrls() makes this clear.

...
 
>>> +/*
>>> + * Attach a CPU to the capacity controller at each cache level whose cache
>>> + * the CPU shares. On failure, detach the CPU from everything attached so
>>> + * far: the cpuhp core does not run this state's offline teardown when its
>>> + * startup fails, so a partial attach would otherwise leak into the domain
>>> + * cpu_masks. Caller holds cbqri_domain_list_lock.
>>> + */
>>> +static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
>>> +{
>>> +	static const u32 levels[] = { 2, 3 };
>>> +	struct cbqri_controller *ctrl, *c;
>>> +	struct cbqri_resctrl_res *hw_res;
>>> +	struct rdt_ctrl_domain *d;
>>> +	struct cacheinfo *ci;
>>> +	int i, rid;
>>> +
>>> +	lockdep_assert_held(&cbqri_domain_list_lock);
>>> +
>>> +	/*
>>> +	 * Hold cbqri_controllers_lock across the walk so a controller
>>> +	 * registered after boot cannot corrupt it. The register path takes
>>> +	 * it as a leaf and never cbqri_domain_list_lock, so this nesting
>>> +	 * cannot invert.
>>> +	 */
>>> +	guard(mutex)(&cbqri_controllers_lock);
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(levels); i++) {
>>> +		ci = get_cpu_cacheinfo_level(cpu, levels[i]);
>>> +		if (!ci)
>>> +			continue;
>>> +
>>> +		rid = cbqri_cache_level_to_rid(levels[i]);
>>> +		hw_res = &cbqri_resctrl_resources[rid];
>>> +		if (!hw_res->ctrl)
>>> +			continue;
>>> +
>>> +		/* The controller backing this CPU's cache at this level. */
>>> +		ctrl = NULL;
>>> +		list_for_each_entry(c, &cbqri_controllers, list) {
>>> +			if (c->type == CBQRI_CONTROLLER_TYPE_CAPACITY &&> +			    c->alloc_capable &&
>>> +			    c->cache.cache_level == levels[i] &&
>>> +			    c->cache.cache_id == ci->id) {
>>> +				ctrl = c;
>>> +				break;
>>
>> Is it necessary to loop over cbqri_controllers and repeat these tests? Above seems to
>> duplicate the work done during initialization (cbqri_resctrl_pick_caches()) that resulted
>> in initialization of cbqri_resctrl_res::ctrl so it seems that after testing for existence
>> this function could just use cbqri_resctrl_res::ctrl without again referencing cbqri_controllers?
>>
>> If I understand correctly it may be that new controllers appear in cbqri_controllers 
>> after this driver is initialized and the resources are initialized so the CPU online/offline
>> helpers may need to take care how any controllers in cbqri_controllers not seen by
>> cbqri_resctrl_setup() are handled.
> 
> The problem is that every controller that passed cbqri_cc_caps_agree()
> is forgotten except the first. I will change cbqri_resctrl_pick_caches()
> to keep every controller accepted for a level and have the online path
> look up the cpu's cache id in that set.

How controllers are associated to the resource and individual domains was not
clear to me. Thank you for explaining this.

Reinette
