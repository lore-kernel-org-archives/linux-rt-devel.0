Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925735218BE
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913338; cv=fail; b=F1OeJ6hIVQ4VI51wNfhMiJYpSwIE6wUoH7uAJxtYzOsck6FO88M28Tdl9Y2K4hs+fpW6nNU+dWtcKAgSUsBWVfUoC9MPuTdK746MVwYSfZYTogtv2ubpfcbJIzwsEDo0zPU8qLzrDy4JDgikmvb5zxC1aIWhCdwqh3rMXjEiQ3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913338; c=relaxed/simple;
	bh=6UqG7Og3ynfd3qLnMPF6H+PDyt4I0qSGAvLYacS2gSI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O244seUaXauAgx71eeZf/1YQDUib7VtfCWQW7o2IWcr6Z/iQFsrXV5tekFV2dMwEJRlAAdtoQFf2YrUQF7Nsy3EqwQwSRmDIWjVDPpZz3LhYFjPofrCfa8kT6V19Dm9e9lUMIkzC5ZqmMuP7SfcKlGOxcuqdpNaAjKcIUDHtBvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXTo3Vqa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXTo3Vqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791913336; x=1823449336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6UqG7Og3ynfd3qLnMPF6H+PDyt4I0qSGAvLYacS2gSI=;
  b=TXTo3Vqaq6EzryjcPZ7FSuB9egBnYJU2B4+awkEcM7USNuVVXMfoCju4
   urvs12jJRBd84REfmNrKPXduo3bKE+kVP3VA6W+8xCRQB3M1/jLkmGnSV
   DaF94InmC8oWec0EhJ3d23xTRWd4BZaEJggWbpiuDofx0rZfkOCTiUfQH
   ZW9I9k9mJdJay0UQsbjFNRx8aWDV8jRLR7y+XTCwoK5cmXqUFCwXc3DaS
   kwTIT0FlE+0PRi1aPaPDZOHPmQeGNSl1mBdYVVejEUKx49bUThaNirkcw
   07b/YxMOUbuLnKtPAe3PqK0qksbrnNn0ZfrNB5UfIAQ5ccfXRaFVjLAAK
   w==;
X-CSE-ConnectionGUID: WTYZpDYcQIGPGz1J4BVrXA==
X-CSE-MsgGUID: zaczKqvrQ/WC6an+K/NFcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="535468"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="535468"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 10:42:16 -0700
X-CSE-ConnectionGUID: +QcjdxcWTCKPcMoXfdszHg==
X-CSE-MsgGUID: Ki7O3DNpShqo6Az6Lf81kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1139799"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 10:42:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 10:42:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 10:42:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 10:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh7k57C6YeU9nOi9Cif0P6L1ZxJ+j+7rVFboARS9BpNxmejXtABKv4ibQP3j88D4eA0v7ye+Bzuxo+mA3djhX+Ah4PTayYVDpx9UigO1a2T3DhDGbGGeuUI1+LiDINLMt4kIa6LXxVQ2anbU3bXXxQL+an7zpbxfwb/2lIV4hADq4XQKe94OUA9Op78XILPuXFDAj/40qL/gCnh+aIE1CEcjMf9k0qbS3cczmi+8M7IK1XxOQQ6DEITSOR5crqM9t/f7PeRZQhjB8XvWNeN8rJQGuf3/0t6anKIJq1IpB6ogI2XbevnZfKLjv27Fg9qBEeVtsC+24m4PqjliEh0nEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7lbYvjwhL94Adh60zb1cFrdvktSC10ehs+rdF8L7tc=;
 b=NWkmJWqIL/cc2jNqM27ZrwdYGLs3/knmWmcc2hCG8XJMRQHUz/vrE6lsTVKGxDAHPjevuuHr0QgQ88oXSRvqHZo6/4UCdbiAV1OhveaZlyDvDfh2LSM5vpvcNjMXoaEVF1WRCIWs11qRcfSKgtWzCbQl4mmsOUhoZbfO6QgheY7R6K1wJlyqsc+IdS32Qhw0xqLSYSPzCng7GJvYsji8amLjNNo1B7HHig9txU92NT/rKPrXYaaI/LnB6raCv29gHN4mLoAHduvmVjC9thXSUveaRr3ttPVba9dD7OFgv0qSU/Q2fbum1kt1gsLdGPB/CLCEhvjoEcvw41Q/Any49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 13 Oct
 2026 17:42:10 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 17:42:10 +0000
Message-ID: <a85a5aef-5468-47ba-afba-8bdd666dadd4@intel.com>
Date: Tue, 13 Oct 2026 10:42:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: "Luck, Tony" <tony.luck@intel.com>
CC: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra
	<atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Babu Moger
	<babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov
	<bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley
	<conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, Fenghua Yu
	<fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai
	<gsh517@gmail.com>, "guo.wenjia23@zte.com.cn" <guo.wenjia23@zte.com.cn>,
	James Morse <james.morse@arm.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
	<mindal@semihalf.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"liu.qingtao2@zte.com.cn" <liu.qingtao2@zte.com.cn>, Liu Zhiwei
	<zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, "Paul
 Walmsley" <pjw@kernel.org>, Peter Newman <peternewman@google.com>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Vasudevan Srinivasan
	<vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li
	<liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
 <8230dae2-2cb0-4b46-8cec-dc4e281d4e4a@intel.com>
 <aqwN1szItGPg4Qjh@agluck-desk3> <as0Zeoyjiy5CW1DT@agluck-desk3>
 <eaeb4259-46d6-4656-8354-669ad32654b5@intel.com>
 <SJ1PR11MB6083F4281EDD036A4E73A532FC9E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083F4281EDD036A4E73A532FC9E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::35) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|IA1PR11MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ebee79-338b-4f40-71d9-08df29514e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|6133799003|3023799007|11063799006|261009223027099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fctgLK7Mh7gudBbyg+sJ2Jkyj9NEDWh3+3eFnv5OAwpgrIHRxtFUVt9lgXR/OPU9o701X7VwPfTcF/6gSgtPd9cURk4P33KKvSFdCrPlsgti9wUN0UFZmYs/O9lXg8iHUMWaTkdcOF2vXwmdLjTgxfBsvueg1A0pqxFIonNuWAsmil3Ly4f6afnNi6ll61P9v95MMUaK0imBUV5su4xMe4wMtORjHGJDRlBExSPnCjF8tF0dJbhddb47SHqWsuTgMhYSTU1Nr7eClhbGLI+YZkVubD0/CSv7jmZhfQC7Oalnan0yOY8/+Ad8tNvxiZ00X9MBH3oTOdKHlR3a7yFz2J6FP5CPulPiJTBa407gJMXD8Bl8X6MaO1uiHdu9026cDNHI5v3X8Sm9eYDjgjgRhrnzMGyeFUbineJT68oqcRYPtO2Ng92q2OQknFdlPAkAaGFQ8/qYOlMI5pVea45D5VzN1TIzkte5Je1bi/CWn25ES8ffW612H7Xm8TzigOW66J+hZxnQDRyINUTIkSgaxIBAR2vOijcDkXsoLNW14i0K4Vc252x/pzNCbeFvqkz4bpQ43FUeF53CcFD7EUciitJCrB2rgW/GwJYJzP23su7ZsRI1utVJUj/wdJ5z2dn3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(261009223027099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFuelBIU1N1L3Ryajc5NFpZT1FkM1lDT0ZkR2FEOTBCc0ZRTTlUc2J4dDZO?=
 =?utf-8?B?SkorZW5mOVNIL0w2SXpBWUR4WmlkWTJDZFdadlZiNncya2dibU1iRHFLbXNO?=
 =?utf-8?B?Z2UvUCtMbXhvZ1dTaytGZjhlVVZvRFZ4NGUxeHV0Vmk3QW8rVDF1UU1Xa1du?=
 =?utf-8?B?YU9JWHN1bnZqZnFEOHpVbVFWSEVMQVZjSjQ2UFRHc0VzVURIN2lCZUl6bytn?=
 =?utf-8?B?UXB4ZVBpSWVIb0k2QWlReG00SWhOTkgreWFtRG9WZjBIenJ1LzZRN2tQUjlU?=
 =?utf-8?B?akJoV2RXaW5vckpDSzZxSVpBZEsvVjZQdlhOQ29GTkFvTEZoTnlQaVFyVVUw?=
 =?utf-8?B?MVV1eVR4TkM2UVQyRy9KbXJUL2FvTnV5b285VS8zVDAzMzF6aE05Mk5Tell3?=
 =?utf-8?B?QittSTVQVTI5T3F6ZXJVbCsvZFFabENVeDlnZlNxVldhckhUVnA3QUlCQktC?=
 =?utf-8?B?MTUvc0k4R0tnZkNtSG1QS0tFRFBEbUJTcUNZZnRoT3VRUEd4amRjQkFObGxV?=
 =?utf-8?B?NjJBUHFrU09IOHJ3UzQwMGxTaXhKaXRFdzd1VmdldHB4R2tWN1RoUGR2V1cx?=
 =?utf-8?B?NUswZEJqRDB1MVJzMCtMb280SUovQzJmODkwQVZiY0U1UVYrTk9Td2JicmVM?=
 =?utf-8?B?TDhESVFadlMrRGdnY0M4QjYycGVpcmYzSGM1MzlHVlJqMVJqRWJUUjROanhr?=
 =?utf-8?B?UTVFS1d5aUpUZkNnclUzYTJ2RHFrbzdVNjZSS1hlUmR0d1ZYWmFoYXd3UGp3?=
 =?utf-8?B?aEw5NkI0a0ROQ3lLU3pCWVBtVXRyZ3hRWUd6MDEvanpKblFsVUozWmJ2OTZT?=
 =?utf-8?B?ZTRUc2JmSzk3a2t4MG95bnNqV0VRTENxOGVFUHZqTXBWbmdSeTJZak5kRi9s?=
 =?utf-8?B?bTlDaWxDZ2NncURoM0xpWnVmU01UWTVRdUFHd3FmcUtDeFRSY0tZWG1mUi9a?=
 =?utf-8?B?K0xqb1dZQzl2STB1ald3Zkx5OEdYVkxTNWZrU0ZBbGozbWRMdnh6T3ZXKzRj?=
 =?utf-8?B?ZWkvcWRDeHBXdkJMQjhUZlVaUlgvOTZ6N3F4M0lreS9MbkFkcUtjcjJ1TmE3?=
 =?utf-8?B?NU9weTVWakhzV1M1OEFwMDdxMDlHek1wbmJwTHkyOVM5SVJNNmpTalNZR2Z3?=
 =?utf-8?B?Z2crV1I1YkNuZnVGaklhSTVyWHNnR1ZpSVBQMDcrS2d6VTBJZ0VXdE9SS2hw?=
 =?utf-8?B?bDVqUUgyZ3E3dHVkblNKbS9LVmU0SU5keEZNSEgvaStmZENGZEh3SkFkbFcw?=
 =?utf-8?B?dXpUbXVJd3JnT0N1UkZBZWROSWVrT29oQU1DZFVKY0tCZDNVZElEQWJrZWdL?=
 =?utf-8?B?YjVZam1sNlU0VDI5ak5LSmNxa2Z5T3ZOK2NZTFl6MnlZQnJMdmQzcEFUN0lM?=
 =?utf-8?B?UkRNdkZoclg1Sm1zNVFHaEtneU5pWEhvQ3BZRWtRYnVEdnZpNDRjNmo0SVpy?=
 =?utf-8?B?TWZhenF5Qk5MNXpWakxwZks2N3hIWVVNYVArT1M4T1hGQmZuMmJyREhzUkUr?=
 =?utf-8?B?dWRzb3JnR0NFNEhoelJiaDhEckN6OXUxa2QrMGxEcWIyOG1ETkE0V0gvbEtl?=
 =?utf-8?B?RUt4cEYycXpxVFZHYmJ6M1JKNDFLaDFjZWJUSjY1VEpMZkR2QTc1OFFsazBs?=
 =?utf-8?B?SDhOaVVuWWVXSW1HSllYV1M0akQ0ZkxhWTFtdXJvZnhsTnRmVGd3Qy8yS3NE?=
 =?utf-8?B?Q2cxdnVXMGlWTTZEWDgxa0ZCamx5ZDB2ZGlDVWxSYWR0bjJJTTRzeTM5eDRI?=
 =?utf-8?B?L0cyeko0cG5JMWs2WXI4cTFIbDM3UXJreitROFZMUVlzWU1LbkVEWnFUTGFO?=
 =?utf-8?B?K0RSOGZoR3RVaXpreHYyeVo1V1RtQThBRDlUa2luVzFaVURWT3JpSk1hT0c4?=
 =?utf-8?B?b2F6bitVUkp5Nm53YURsMUFqSkU1ZjZ5U09Ka1dGOEYxZ0tQdmZLQjJ0Qi9y?=
 =?utf-8?B?Kytwc1Y5N00rZ3QxNWFYQy9RWXRKQ3AybGtxbWYrajZacllaQkhiRk5aa2xG?=
 =?utf-8?B?d0V2MHNkQklENTM5dW5ldVIweXE0WEFpdVRkUW9NZGZ4RGs1RzVuN3R0bldK?=
 =?utf-8?B?ZnJHSGZGVVd1aVRUOEtZRUwyblBCTU83VmRDV2hoVlMzWDg4aUZXVTh4RUhF?=
 =?utf-8?B?Z05UT3hlMjZBUHBjTVozT2VuM3cxb1o4dDRsUXlwNi9pUWhZWmd6M095V1pm?=
 =?utf-8?B?aXR6dkRsOFBkcm4ybHZ4WVJUeDZDVytEVnluNEtaQU1YVG5ld3JMblZlSXF5?=
 =?utf-8?B?VnI1N2o3R3dGR21xR25vQ2xBYit4M252TlVoK2J6dmp3OWlTVkJvRU5UeFdw?=
 =?utf-8?B?ZThzNTRENm1vYmRSSURjdWVENEZNUzlJSUpadDhiNldFL0dlZ0xsSHpJbEZm?=
 =?utf-8?Q?utO13LO5LNN5jrhI=3D?=
X-Exchange-RoutingPolicyChecked: 24npp6v/zKwNvSlSe5XqnKGZuXT9cr30YgOawOfEqtZF7cudnI9UR9JrZiBPbWZq28itTxvIJGwgKi9wMVM/5aLJO6+dIOW79NqYGsS/Fo+CdI/xPXBnEecOroI2Uvl2uTdEpjGHV6XkLuCbn8VtPzpGjp1I8URBwAZcLHUGHeGll6lQ7EkqN1nVIrMUFjW1IuRDJM80PspYSGHlK0CMDQzAyWWoTwFed/W2hmoz0CBjONr0AbacWCwti1a5HrDizz1CklhWwhtZylg15gtzH2Cne10XmIv+aTN1TRZoZaemyaIXX/iob2+ctvv+3wVMsxLfwuWDh4ak4c+OgaIgLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ebee79-338b-4f40-71d9-08df29514e5e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:42:09.9834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lh610MZkaQ1/r++Jpn24MW/t2YEaUMwmXDpyJFsQhV7fcvO08SY/BMMTrewStYBCLAn1SGlqy73A5wuYWWHpEIPiIRIP76Z5Pcv6JTCvCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com

Hi Tony,

On 10/13/26 8:55 AM, Luck, Tony wrote:
>>> 3) What should happen to the legacy /sys/fs/resctrl/info/L2/cbm_mask?
>>> Just hide it? I also considered renaming the resource to "L2A" to
>>> avoid surprising legacy code.
>> The current direction is to have these top level files continue to return
>> the properties of the default/legacy control while in "legacy" control mode.
>> When user space switches the control mode then these files return empty.
>>
>> This is what is implemented in RFC v2 so you should be able to see it in action.
>>
>> It was noted as one of RFC v2's opens:
>>       - When switching control mode to native the top level control info files
>>         stop returning information. This could be considered "work as intended"?
>>
>> An example of this behavior in action as applied to "min_bandwidth" can be seen
>> on slide 4 of
>> https://lpc.events/event/20/contributions/2368/attachments/2066/4625/resctrl_2026_combined.pdf
>>
>> Hiding the files could also be an option. I have not heard strong opinions on how this
>> should be handled after the above mentions of current direction.
> 
> My PoC hasn't implemented anything for the control_mode file so I get this:
> 
> $ cat L2/control_mode
> [legacy] native
> $ sudo sh -c "echo native > L2/control_mode"
> sh: 1: echo: echo: I/O error
> $ cat last_cmd_status
> Changing control mode not supported for this resource.

The current PoC supports multiple controls for cache resources but does not
support switching to native control mode. Only MBA resource can switch to native
control mode.

resctrl fs built a couple of features on top of cache allocation that are exposed
to user space (CDP, IO allocation, and pseudo-locking). It still needs to be worked
out how these behave when there is no legacy cache control so for now these features
are hardcoded to be associated with the legacy cache control and switching to
native mode is disabled.

> 
> But it isn't clear to me what legacy vs. native should mean for asymmetric L2.

This would be up to the architecture. One possibility is to have the asymmetric
L2 control emulate the legacy L2 cache control. I did not really consider this
and just assumed the legacy control could be expanded to support different sized
domains. 
> Potentially: Legacy mode: L2 is disabled to avoid confusion with different bitmasks per domain?
For "L2 is disabled", are you referring to the resource or the control?

If legacy L2 control can be emulated by the asymmetric L2 control then a user space
can continue to interact with a L2 control that pretends to be symmetric on an
asymmetric platform. An "enlightened" user space can then switch to native control mode
on these systems and interact with the asymmetric control directly.

I am not sure that this is what RISC-V has in mind here though.

Ideally user space would not need to be exposed to architecture differences when
interacting with resctrl filesystem. This means that a solution like this would
force all architectures to do something similar for asymmetrical/symmetrical
cache allocation.

Another option is to just support L2 asymmetric systems with the legacy L2 control.
You state it may cause confusion - I assume you refer here to the schemata file
showing different CBM for different domains? The legacy info/L2/cbm_mask needs to
pick one CBM to display, which could be limiting. This is what the new "max"
aims to fix. 

Reinette
