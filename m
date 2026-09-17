Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F515172DF
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662476; cv=fail; b=DFSfbNqsOvNC269TgkC/TaDBLzITnvC5GJ9+CBexQoenkWzMc9BeR12FvB7jbhgD43rReH7IFCWWjxpF5abiddIyGiNWPPh38dFn98r1eJ0pGvTH4YDzKGzTQj4q9Cep5K5fJvj8PJKC3I8baJL52ojRHPYJQinJd6khsAKlc5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662476; c=relaxed/simple;
	bh=GB2I1AMPdBB7e2hEP2HwEzlqO6/52jswQI6TRq67SF0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YYKJ0wehxxRGb5/LfQPwI2Bet4UPLgwDHyGLHSudMe8w9YxZgYoQpdrspJ9QHxpZ06xMQRf883MDMh/gc1aNeEN5so4YK0VbpQVAa74VetLi8IX7UXXA9Ay9gnnWySXzmju4lPI/2dYZemY1G6yGFhdWW9f6H3+kCvsMD7HKQqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQhtyp2b; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQhtyp2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789662474; x=1821198474;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GB2I1AMPdBB7e2hEP2HwEzlqO6/52jswQI6TRq67SF0=;
  b=NQhtyp2bIqHb93rTr9uqFniZCA7j2vx+6lfdeD1924usAgs4KKXEgpm8
   0UWuD1MrIRM/gOfoA/AJDUUbWenqHE48gugTk5+B15HaqGzbqN7Z2QKaC
   zQkygYKhEdhZI5vJGXHKH8K74WYFODtySTTRGGHhnm6TYT3MX7eDR9wz8
   7BmzT/GiIIKZ8WyYNoAWIU1I3KJSA78gqbp96GIT0vtTdF2mPNhIX4q7a
   o/G+8tQNTAEW20lV5cB7zWCK14RbWBgTEdsSoihm/yRiPGJmGf/crwHLA
   St6nnb07HyTd3U72zcU3Rd+BH5doZCcVMwXssbJZ4LlwVVFId+VQprWFe
   w==;
X-CSE-ConnectionGUID: QLruaN9VQ2iWdrT0UQqyQA==
X-CSE-MsgGUID: eK1qzq44QuuPRK6wpEsnTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93934365"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93934365"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:27:53 -0700
X-CSE-ConnectionGUID: 9P4CVzcLQtqKEpz9qhaHsg==
X-CSE-MsgGUID: DFgGfH3CQFCJinlrkkGyCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269622971"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:27:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:27:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:27:51 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:27:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbntUTQzORYgKGcn5QtA5xEDC1tVqvfu3YJvLb+rx4JSMp0eR35shOOoKr73xfpJwH2s435+5uWVCLUbrloCa9Cf0eAVBJK8QCOxqPakDrpcrMcGqkJ59RT0wt0pE2EKF56R1Ws1rohf1laolUDtq/Qcid5RY+hOXcwSjU6QVbXkU3IzWyWgbs7ib3EQM0mPXusQ30b55S1yVT8Tw+mnSHiVe3t4lyvkoiBdQht6JHudln67oHfUNmxr3NHu6dEjC0ntHlDT3awpN/kAO2ejoCTC5DQ9A6hVD4fEK3d7Q2J9YObEJPfbXjH6nEM5JejNWfES/9CL6LMG4GOMf2enJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImjZqqW1PcF7f0tYmMp6W/cpGGZGyMAjlsm5dv6F4p8=;
 b=H1RyXvPVjiZI8uVhp0KJKeuubB+Qwtc2tJncrWvpiYqSCkfSC688rpv9FcpwWWsN/r3lWrCa5N0ERw72kNfuTQ1YO7sxLFWAysLmq7TJXn5TcFEogjicFco5weg8Dfr6kB78YkiEGIAlj6DYWm+t1Nl/VH2nBjkH1q0WlHryzGCk1asHtja1s6F/LgprDCVrFzZcMys9Wwf9/Wt21VUBr0tLheSIN9RVVXV4CcAq9b4Ui69YZynErvuDTa8rbM8e/Pht86EBkwv+LfOSuJxiasHnL8WHk9/YRFJMAcQhDeNDY9k49XJD6fswDqos4ZkfRjpcoUNAxDEAfzxwfqOFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by CY5PR11MB6438.namprd11.prod.outlook.com (2603:10b6:930:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 16:27:47 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 16:27:46 +0000
Message-ID: <76048b44-8faf-4fc1-a265-478ad83ff7b8@intel.com>
Date: Thu, 17 Sep 2026 09:27:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: Drew Fustini <fustini@kernel.org>
CC: Adrien Ricciardi <aricciardi@baylibre.com>, Alexandre Ghiti
	<alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, Atish Patra
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
 Andrzej Siewior" <bigeasy@linutronix.de>, Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
	Weiwei Li <liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <linux-doc@vger.kernel.org>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
 <8230dae2-2cb0-4b46-8cec-dc4e281d4e4a@intel.com> <aqwS7qgGNkSHxoSz@gen8>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aqwS7qgGNkSHxoSz@gen8>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:303:b9::13) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|CY5PR11MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f74f804-7d89-464e-b965-08df14d89b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|3023799007|18002099003|6133799003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MkslSndxo7BneS16HCsQxJSZtWJycLDmJgAcED8BuX1zRDt8T7MMlC1QnOj1lH4Ntmv3EeftgnBzbEsBG3Qmg7EsT7VzJxD5lnlQa12yKhdKD53cQfy5H9QHjdSk2RQSduZY1nTOGKElktl6jlDtWmi06HsGeulm6QgWS5evzsndOq5LN1GbAINouEORXn5hktiejofgMbV6wBgRhF1n56NTqSVZmAIuYU1cM8c6w3dNiBAaL2U+oqIT19+GDmIH3K0OINUXEpNuSRy5NHscuojAtYhIoNxK7k8oprnzENesWWKd4Clrw3VHZJlqGgOiSyXUvJkFfMNf/FscJX9oaa67qNh61hIO+zODZYZWPwcovfW71bjYnwoL392MYxkzY3T7v2z8FGjyvouKTn75HcpMsJYHPH+FPI0Oanb3XvVaMgPPvs7FRmJbJ8obxIVTVbir2z7rVGGd1ISXeQE5WGkK/2bPfNsxITf8Y5qf8I+1NWj7m1RILGK9GWJPzFmbGim6f2CCXO2yqh/nFJAkito+Qow/1GxfYndzZgDwKDSz3WSDc3kDS1SoifImQjymi6lI8L9X4J/euTARLktfnWjl8lTKMSMF3RkvkhhONIBMqbGfnauoUbC8NSleAzNvZIRp0mP2fGRnJf+vaMaNtFGiqKkt2weG7G5VcrOrus0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(3023799007)(18002099003)(6133799003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdDUjhhUkMzemwyUTd4ZjZNQncxSTJsZGVYNHlUNDlYTTJHT2FKQlAwMy8z?=
 =?utf-8?B?SGRmVjRXOWxmTitURy9FTDlFWHRweDdTbUdiRkFGVkkzY0I5ZVhLL2RnWmxi?=
 =?utf-8?B?LzNLQmxXK0lPK0puRGtRSW1OR3lWQjdYcGVMdEdlQzVHK0lTd0pNT1cwZXVy?=
 =?utf-8?B?dHZ4MVVPMXlTNFVDeTFJWUI3dGR3cFhwZzJnVGIwY3VFNVR5YVBxK2Q5ZWc5?=
 =?utf-8?B?UXg1MXJjNzhsQmdzczBCcVdTMCtGb0l4dzN4M05aV240SXJ0QXRKUFl5Q1lm?=
 =?utf-8?B?bGl5NVFXUEh1QStiQzRZc3FhOTI5cHI3eXdKaGtudnNCMVAzNjZXK1B1UE90?=
 =?utf-8?B?Um1OQjVlK0dkY1d0KzF2RkF0b1RLK0gwZExxd3p5ajJLdnJWcmkwRHZTdmtm?=
 =?utf-8?B?K1ZFNnYrbEJ2dlpVdlVsVVRrL2FydW5tb3lJbDRBK0pJbDBic2VrL0hRRjNi?=
 =?utf-8?B?NkQ5VzFnV3ZFYzZ0NGJTQWR0WS9xeVRBT05lVi8rbmNjaitVTjhMTUU0S2Fp?=
 =?utf-8?B?WDdJWkF1bzJIemxsYWdsVGJwaTQ4a0grbCttSmtvOTRRTHBYMTRPNHU1ZER5?=
 =?utf-8?B?ZVBLeHlVRkhKMGZ3SE5vUFRuaGc3dDlEYXdQckh6cHRnVFR6eXpWN1BvWm5z?=
 =?utf-8?B?S24rUkpnN1F4V3ZJNm5DSGhRMzd3U2xwaERqZitCdDVuemN0eEVVdTNSRGNP?=
 =?utf-8?B?RzN0dURjTEJFYTdwbTFGT3YxSmN2NS9MZ0dWUm5JRU5PNm5md0RzNnByU3Mv?=
 =?utf-8?B?NFhteVg3SmwyR0VNRWdoUktGOGxrTDN0SmlXVzBEZmRwdG96QndRWmhUU21P?=
 =?utf-8?B?Ujc1bERESHNlSUg4bVNXMUw1bEk1b2plOGxJb09zcndzbDlMSXJyUE94OC94?=
 =?utf-8?B?aUg4Ty83YzlFa3g1NXhzWE5oVUk5RGxQcmxKM3AxTUNKTm9zSHkwQktLMHdZ?=
 =?utf-8?B?ZWl5czIvZHR5d2gxYnRwdjZmM21PbHdUOEZjUkhxcTkxc1hlV3Z3VjRVTWxX?=
 =?utf-8?B?a1BWclFWV3dINzVRKzVqQzRrRUUrbDlLVzBXUnFRQ29jbXN2SmxTWnY1MEl5?=
 =?utf-8?B?RG1RbDBxSnQwK3R1VkdvcmtXaGREVVBPdlhqYUdFckhsR2ZtUWpXZkRrTUJo?=
 =?utf-8?B?bTdXOU9ZZXJPYjNjUUI4ZHV2UzBVTDdKc1RiQVJLalA5RnFaSUxYTlhsNU00?=
 =?utf-8?B?bENFS1d4RTBHNEljbnRiRHpsbjNuRUdGVW9iYWRFZ2U0OG50Nm0xM3dGc09Z?=
 =?utf-8?B?Vk91eGV0RkFEc2JtNmlqTExkVFVRR3RRWXBwd2Q3RjZYK2ZDdHhYdGR1bWdn?=
 =?utf-8?B?bmo3NzJnNmprZmN2amxVdmlPd1UwVU9EZ0R4bmoxOWcxM3NTL0pndlBxSCtm?=
 =?utf-8?B?TFoyVHg4WnRxY2FtTDRqZHJ3U2pkcGtnclRrUWJyMWpqWFd1RUdUek83MVly?=
 =?utf-8?B?NjJLN0MzTUVwTUdtaU9GQjVUdlhqQndKdDFFM2QvTS9qSkRMaVA1OFVoZm1q?=
 =?utf-8?B?Y09OOVVoNDhsUHlJOHhHbkNoSit1TGtXZjVWWnVETWtwaDZKejF5SFhxYXRn?=
 =?utf-8?B?cmpZN2RvZnI2Qjk5UHFxRHdERkJIVFBKdzF4Rm9qUmtaS2p3RUEwVmRXSjhT?=
 =?utf-8?B?bkFtbFIrVktUSWVnODkzS2QrWCtWQ0srWW16b0ttZ0xITytOMURqclRSY1hj?=
 =?utf-8?B?bTRrUkd1UE9NSDlLU1M3WTZLajl4MlpNVTZSZGlwTjRrY0lETTN6anBza0hU?=
 =?utf-8?B?WHVkUzdSYW9yZERhR0FyeW16ZDNkSldBcEtXUUEwQ0hlUzZzZzAyYWVYemY1?=
 =?utf-8?B?YU54RzhzazRkTFVEWkluOFB2c1RKRldDK29SNUUwejI3ekY2WmpnczJReHpK?=
 =?utf-8?B?d1VaYUJ4Q3dORkl5UTdudVBZNDlQVTlRYkVrOWcreEpBWEI3bHNwcysydlJ4?=
 =?utf-8?B?VTRyMXBONGFOanlxc20xSFg1dDFObHlCYzlBUG9DUlBLc0N3eGxVNWZvZ0Rv?=
 =?utf-8?B?anF0djVlNkk3Y2J3V1FQVkgycTNkL055VkNKZmlpQy83TFE4YXJ2NFFzczlY?=
 =?utf-8?B?UGhpTDg2SDIxZU1yeXBuUFFkSkIrUnpEdDdKRFRjWGUyUWZQUDFqZEtSNmZR?=
 =?utf-8?B?eVFJalE1VE5zdDRMMCtITW5xVmVadkJqMXZ4UUtaMFRQUjg1SC9YR0YyTmRk?=
 =?utf-8?B?OVk5ZFlRQW03NlFTbGxjeW0xbEwwaWJpOHNSUkNRdEtiR1J0UCtZTDB0SFRh?=
 =?utf-8?B?Q0haUWJKbDUreit0QWVZRkFJeEk1eHZMQjFFSC9zMG1yMmtjR2tTMkNvdUx4?=
 =?utf-8?B?eTJiVURveVRzbSs5bWt4SUYxYlE0clJOZ0k5ajRRd1RGcGVCTTNMTWpGWTBU?=
 =?utf-8?Q?xhKJM+/6kY5DLIZQ=3D?=
X-Exchange-RoutingPolicyChecked: c+RxvqfQE0MluzTK/4tHugXsycJONjMQ2HWez/L7vL3XhirlfnNOYcPjIkN+qdujhbIcY3/PYH/d4JFVQJtAhOyQ37MtVe3bCeh7XraDH9fsFwlqhXxde/k6hOYYoU5xr4fUvNJQn5u9keKO8crt5FtJLyheRwVfiURsKDtUzndUko8hKKs6HNCexH4QutJrlsgychOr12Ykt9a2huHADoeXWHlfjTuxJV3gzXeQSjE9JLq27sdUL5z9Y8BMRhX1Dqn9uY/8xQuXRr7FXhrqD1cP+9pgoXEcz7+dwAHODlk9wobMM6+0Kt6+UgLnqwEKzSADbvActYZcbc+TDfPfnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f74f804-7d89-464e-b965-08df14d89b84
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:27:46.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNhtBK3fhgDR3612C7MfW6XkqA6Siy+nQHbNOM07sHaFiu9Dfh2b/ESqFXXAw/4Jp8VdVyyTw+z9lq68kJc+KWX60v20bAewqhm7giIpVXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6438
X-OriginatorOrg: intel.com

Hi Drew,

On 9/17/26 9:18 AM, Drew Fustini wrote:
> On Thu, Sep 17, 2026 at 08:37:43AM -0700, Reinette Chatre wrote:
>> On 9/1/26 3:31 PM, Drew Fustini wrote:
>>> resctrl exposes a single cap set per rid, so when more than one capacity
>>> controller backs a cache level they must agree on those caps. A level
>>> whose controllers disagree is left unexposed. Other levels are
>>> unaffected.
>> If I understand correctly, while attempting to translate to resctrl terms,
>> this means that a cache resource with several domains may support different
>> capacity masks in the domains?
> 
> Yes, each capacity controller reports its own number of capacity blocks,
> so two controllers backing the same cache level can have different
> maximum capacity masks.

Thank you.

> 
>> I believe the "single cap set per rid" you refer to is
>> /sys/fs/resctrl/info/L3/cbm_mask and /sys/fs/resctrl/info/L2/cbm_mask that
>> exposes a single capacity bitmask representing the maximum allocation.
>>
>> As you know, resctrl is in the process of changing the way in which schema
>> formats are described. The most recent PoC [1] added new bitmap description
>> files but it kept a single value "max" file to describe the highest allocation
>> possible for a bitmap schema.
>>
>> To support asymmetrical cache instances it looks like changing the interface
>> to describe the maximum per domain (instead of one global value) could address
>> the gap?
>>
>> For example, if there is a hypothetical system with two L2 cache instances, one
>> with a 0xFF max CBM and the other with a 0XF max CBM then resctrl could expose it
>> as:
>>
>> 	# cat /sys/fs/resctrl/info/L2/schemata/L2/max
>> 	0=ff;1=f
>>
>> The schemata file currently and will continue to display the allocations per domain.
>>
>> resctrl will need more changes to support different CBM per domain internally and
>> until then all these CBMs will be the same, but adding this change to user interface now
>> may set resctrl up to support these systems in the future?
> 
> I think that would be a good change to the generic schema rfc as a max
> per domain would be helpful for CBQRI. The hardware I am working with

Will do.

> right now (Tenstorrent Ascalon) does not have two controllers at one
> level, but I think it is reasonable to assume other RISC-V platforms may
> do that in the future.

Looking at this patch more it seems the controllers could also differ in
CDP ("supports_alloc_at_code") support. Supporting that in resctrl is a
different story. 
> BTW, I have been meaning to send v8 with some unrelated minor
> improvements based on sashiko comments in v7. I will go ahead and send
> right now in case you are looking at the rest of the series.
That is fine. I just started looking at v7 and will switch to v8 instead.

Thank you.

Reinette


