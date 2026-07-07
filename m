Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270A3DBD60
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448543; cv=fail; b=fFUjnuH3IyfIqSU3NA6i4fFKP8b7zkKmbhBNBPuWXQ6Z5Ih6EjbUxlJVPDyKavxTMbBd3Qml/rbTTUHxMB3JS11QpDqDgBB2xh2295chI35J1mI1SqteOBxI9NMQiK8vfFipL4O//KHFOeId13qce/l1YUBrtLIrHmi46zUoduc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448543; c=relaxed/simple;
	bh=9FHZOqY17Li9O4LPsJRYmty37uUozqvEB17ykHUx8is=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q5CF/VJb9U1g56+Uex903FTgpQ8EZOwmBSZjiIncGzoU+bcoiMC7D8vS+6iJOP+LJagZvsEYCuSdL/Kzg9o2teNDzAKxYzoByx2Vry79m1KwVP2MNalsj/y3RItF8NjYMhynkOLVaWxVLbW8cY3CFoD0GbIX2l/yu4oX0smeDas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+/sj0Mj; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+/sj0Mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783448542; x=1814984542;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9FHZOqY17Li9O4LPsJRYmty37uUozqvEB17ykHUx8is=;
  b=Y+/sj0Mjv5WQWYPn9UVjU63ypzwDTwcvsgjuuaC/Fs5aMPagLfwElD14
   GOMxCYju6mnFyeEPf0amq2v7xcxYqlqc+uXEBJ3fztokbB09TPnx0vGqS
   K/jj1b8chnuH14wFgJzOB80pZ0UNNtb/V7UYoKzYvBXFl0ad8lIJ5B7yZ
   rKd7M0ouWLwLmJ3HlT651qqhjpTp0cBmoYUlkuKKXZ80HwGLQa9jQ+7cJ
   fvXrK0GFC3Z+kS8PdE5VBUEqQV+UVvV4VrbNgEQdRziEXvg80ep7p8qnj
   XP6Y8sE97VqChE5anxoZE+GaugiBYZb10NNX/WDEGtrTTToAWv4byCySC
   Q==;
X-CSE-ConnectionGUID: DW+k3o8TQGSezzliERh/9w==
X-CSE-MsgGUID: StbqG7P3Qt6jCGhu+TYWsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84298507"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84298507"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:22:21 -0700
X-CSE-ConnectionGUID: cm5xMTuyRIqqpB7Ir0oLCA==
X-CSE-MsgGUID: 68OrFSOlSXKGu7KUrr1Uwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="278441764"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 11:22:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 11:22:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 11:22:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 11:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ktm27RkP+yv7KvUsOiG9y17PneXjc44roMDAjkbNg1pSouuQSZEOrt1z0as3xT3+8JW7vQ04hJTGjrSMHaP0qixcP7DigWVL4wwn/b39v/1F0O9fStXG9HYLNRd88fNlAtZ32Qj5SNrO9/cFTGK8uH3R16/ykWH+9pKSxxz8AdL6t0PZshDVwZK5vCzoob45UUAFuz+CXKIYq9D720NMTLUBWKBK7eer4kMOhdVgSw+GEaIWxS43DsyeuKsZcgd/iVFftaz6uyKTh9XAIzYB+U9OXLOUeCRGvtEiZPoa5Wr2L7HwLcLVU9zQt5LyzsC7JgtGngr+KcH7+uP0HcFBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBVhMD68JaY0bIaMfJYY5C3He9Er08VFvm0KuPnZZPc=;
 b=WwV0DbRoL2+ciXjbLYstOD5+T04Q0fDs5hwkq4va+NnjOfbJBwY+R7e8FzmWy7Ix1K5r3ttyOCF6RHSddcUY/cbe54y7RJuURAwn3ej+al1Zft9pC4kHX1reBlS0Gdw43heoKtSIvkqTvCwk/IrXHoqbgZolhdClhqdwKfDYSBEBRiwy5aI9boI7NoTQ4GRsfOFww9dMrvWvWHIlsT6axDBBRogMOOW7SHvsNIqTmDCtxnDeB+Vx9dQr5GRKIQT0WldufoMHH2i2Gi3+/sr1YraiSKEJ0L/RXyX1j6q2gqJUpOmz/LQ+BR4frErOJmdGNQYlyRf0YOD1efGD1FdHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by CH3PR11MB7938.namprd11.prod.outlook.com (2603:10b6:610:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 18:22:14 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%5]) with mapi id 15.21.0159.018; Tue, 7 Jul 2026
 18:22:14 +0000
Message-ID: <70c9d487-93e9-417a-8b2e-bd04f5e413fe@intel.com>
Date: Tue, 7 Jul 2026 11:22:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
From: Reinette Chatre <reinette.chatre@intel.com>
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
 <ec899c62-35e3-47c1-8d42-47eff084d30f@intel.com>
Content-Language: en-US
In-Reply-To: <ec899c62-35e3-47c1-8d42-47eff084d30f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:303:83::24) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|CH3PR11MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 69788268-825e-4000-0b5e-08dedc54ab83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|56012099006|11063799006|4143699003|921020|22082099003;
X-Microsoft-Antispam-Message-Info: EPIlEWgMh4JeOC+eaDL8OdXjcRSDz2cmsbSXgs7tA3+YvPb5Smhj/1owfN0b499/44zLbwXVAd2MYO0cQfQ0AmehnoafathBWUchUEWt9PzEzvOTIhOWysEZ0aEdJ8tbgZHqphvpVi0f3FgbrnhwHda49Fw3L1Tn19NceklRJH4FNzBJxJa+WAsXECHBfAohh0vnuHw9pHkKXd/RqKD+sXykeyzPESNr5l6OcEuFlvAIdKN7a5aHbedggT3dKGoP0XcYxI0B2VxANNBzK8KsCtobztz/MiKlkkFLRGYXVTw2K8wSQp5V/xPmPF9LowNMYHX619gYnWKrdGEtPacOdbsU5PJlKCAoxcd1GT+Eu+MYCKAWz6REWl7Sa2G+lwN4c6sA/NPN+95aAxaYl3bS/N7JjfhQwNLtkTpUAITs/GHYM67Xo7sUdxesDf5IWp07IKNymyMJv4plMIOJmvJVJdbOF2BLlIJP5zfXOvn4/O9V4TC4E1MikBUKlICyTh4a/8jyRUcA+aVRp/KxlH3smk/FAzF26SjP4LdlUVboTuQXbWNmlmVXsXN2WWlBrL818JYjMY37km7vUVrARL3Q0TGAdCu/YxJ5eYdozXS2rjNQbZtxNe/9PVjDYBVFQe1r8UYhWvkZE7Hfjdi01rhdti6ZSDcUPKBhgeL/0/2k/DVkViaoaQ4pWs8ShIXskfjDvpQm2B68wYQlIqmf7IRQfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(4143699003)(921020)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJneW9hSnRza0FzSFdHcStTTS9EZ1Q1ZTkyQTM2eXRWdnJaNkpUV2ZKZllV?=
 =?utf-8?B?SWJoTWN1R1JqRGtmVXhpek52YTdsTmtiV2xBRmV0a1F6Y3B3cVU3MTEwWTl0?=
 =?utf-8?B?Q0ZuNGtDK0ZQVDhlaDZoRlpRU1NUS0JySTBqeFZ6VkthQXNwZ0QvSWFjRVVC?=
 =?utf-8?B?TFczdy9mTGx4aXZaTklyTGZ3ZkNpcnZWZ2F0Q3hnYktaTUl2eHVTUndWMVZJ?=
 =?utf-8?B?dzlDNjFvN25xRUx5WVNFUjFQM1dTZkNnK3dYbkRDR1crZmQ3NnpIeERpZXFI?=
 =?utf-8?B?K0ZNSkdVcmpUTGpWb2JCdEhpMUVEQmdybE5RaGUrUFROSHFueEdKK09paWNs?=
 =?utf-8?B?YnpMRVhzTzRqeVFkNEpncTFUN3lUaDdWV3RHVXByL1lmRTZwYzBTbU5FclNm?=
 =?utf-8?B?S1A0YUtoRkpNd1lCUlhKMllCR2tFamRuT1BhVXRnVkRHckdtQUhvYzNYclNR?=
 =?utf-8?B?NUZUOTVXdk16ZHpGZG9EYStkYW8vSUZLR0JSQ2pzM0tDMEt6NHp2V1BuTjB6?=
 =?utf-8?B?YlE0N2F5RHZiS3ZXUi9jcEtYb1lweEFSbmFmT2wycEtzMWJLamRQa1lWc2ll?=
 =?utf-8?B?TDdxWUtmUjBJUDRaN2FGbTVBL0d3cWgyQWJCRDNaWXltZ1dITkVRS1hleWdR?=
 =?utf-8?B?ZHEvc2c4dENac3BQSjJPSTRUZFkzWk90V09VQzhvbkk2WmFZVXdnWFNSSlRo?=
 =?utf-8?B?VWtkdmNzNmpPZW1QYzB1TlNKYUVsRk5mdEcyRlBaUEloWkNvS3RreWVBVXUr?=
 =?utf-8?B?UWNUU1ZINTR1WlJDUWsweU1HMjBYRlBaV1RKTGk5em42OE1VRzM0cDF3aCtx?=
 =?utf-8?B?QUxoTktDODluU2xjSWdjYzV6VCtzTUJEZXcwRS9EWHp2M3U1SFJvNkswZ3JS?=
 =?utf-8?B?WFp4QTlZZzFobjNlSEkrUVRkZlpkNytDcXhRNnJuTDZIRzdRRzJ5dVhZN2xE?=
 =?utf-8?B?T2cwYlBUR1h0R01IQ0FKcmRZbGNuMVUwa2xydStvM0x1bElhQWc4VjRvaGFV?=
 =?utf-8?B?c3pGeDJmYkF2VERhZmRvMFJzeU1DbnFwbVlSUlZXWTdJTXdSeDRLRXpUSE9z?=
 =?utf-8?B?TnFSZVZrRkhHSjREV2xST0RodHhOY3p1RGVrWXJhSDArOEdQelpjRXg5eWJJ?=
 =?utf-8?B?aVdQQmlRTmU0MUFNaTlrcFRPNEJuYU9lSlNMQjVsaDJndnpKZ3hGRjA0RDZx?=
 =?utf-8?B?aW9tZk5oYVAySitORXhNK3NjQlBjNlU1MDM2NUx5clp0S0hOWk1JVzJROWRO?=
 =?utf-8?B?S0NDclVKRWVsWDdXZjhydnNPMkJDV3BTNFZuYlhsV2cxWDJtaVJnT1RnVlpV?=
 =?utf-8?B?NnRaaUFBSFhCcW9Leng2aEMyK0Y2RWRScFpCa2EvWTlLYURuWnROUDZyUDlL?=
 =?utf-8?B?bWNSdEEvZkN3V3c3OStiTmsvSjdNQVR4OFBxZzV0L0ZBRlNPQ2NXQmZGeWRq?=
 =?utf-8?B?dkVIK1FQYkFtRjFxRzFNYjljR1dYaHFCbDk5cnZjUXZSY2Z4TThUTE1IL2VV?=
 =?utf-8?B?Kys1T1lzNXlLTXBqVDc2V1p3UkJ0SmhRMVpEUDB4SzllYnZ4WCtQTHhJRldX?=
 =?utf-8?B?VzlXSEJvNXRKL2dGbEFxTzd4RVFHUndDaU5KenZYa3E5VUZqS1NNRFZZMEcv?=
 =?utf-8?B?RE1uenFhZ2cweWVMNEd2RTRxUGZSbk93T2lVdkhET3NsQXdXYjI0NDVyZFBM?=
 =?utf-8?B?U284NURrdHRnbWtyQnVWc1NlK2QrUE5KVXZETnBJNDdvdXhvYXl3K3hhcWg3?=
 =?utf-8?B?Vi92bE50QnJ5NGdBdlFBdEhvMDhTYWFPa1dacjcwTTBYekwrYW12M3pWWmR5?=
 =?utf-8?B?d3Y0cHZYM0dRM2t1VVd2cXhxMDZCSE8vUE52TlpMTnBLb1QzQjJUWmx5UURV?=
 =?utf-8?B?WGpNYklUeGQ0UnNRcy93RjFSTnFtY2FMcmtRcmZhUHBLRHFRckR6WXU4aFZP?=
 =?utf-8?B?eXMwVlUzNktEbGRSOUNONlczYmZkQ3k4Ui8vWDd0R1BjVXB1b0tucVE2aS9L?=
 =?utf-8?B?elhUdkN2RGdKU3BBM2RCZ3BtbzVNcTBneHh4elUrU0d2dlF4cFpkWm9KUUlB?=
 =?utf-8?B?TVQybWsvYXNSbVlJbERHTDlVYkFRZ1IxamJNNVl5emFEUGEzWjhrdWFSOWtI?=
 =?utf-8?B?RHdQTnVBQnM5WTRJNExUSG4yY1lZZDQ4bzhzVXZpOUpERlhGUUw0QUpOWjBz?=
 =?utf-8?B?ODNOclZabCtmMms3aUJlcjRSSFpLc1JRMGdUaHhDTDVqWFhLK1M0NkJ0TjdV?=
 =?utf-8?B?YXU3WnRpWnJvYUdjeUpqRlozMnROUlJ2UVdhdWNWeVZ4UUgrbUFMaU5BOE1J?=
 =?utf-8?B?TDR6czhmMDBWOGVEbG9HUURUc0g3b1VOSDR3L1V6Tmo5NnJtQVA0UXltZGlq?=
 =?utf-8?Q?3NwBEC9/UFiJbUtU=3D?=
X-Exchange-RoutingPolicyChecked: Rq0klJVNVnDDHarGLZmByV0yrTyUgiSq6wACPME+Q8OTqeaeblPSzjNHpk5woR91p/jtD5IxsVjLJH47TqoBALTaX8+K6U7AcN+lmAeUkpppnELzOTSHqV/Zp8Ksx/Zekm3xgXCScNgfY9hNloLOjg7qGbWhxtKiYerjz75iDGs2PXEqzw0whMecQhBL1wOjEFfd6VLnf+12kEwIRQNhuPPliJ3O4uSHGZG3a8EhJzrp0BhYLUfSsOobRdpkoBQbzdlPdtVNijtwTPJIugIJibsilQ+R1t7m4qWTZRDlUIfC0BB4byDihXl7RR0FSHZln7TAH/S3tBEnKVfXOMOV2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 69788268-825e-4000-0b5e-08dedc54ab83
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:22:14.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P6ibp9WviG1RF2iJGjl1HXie1Ljjdffsib/KZkhjYAWCrjeMNuu9Xaads0Z0hkZblivjwsvshNUT7roJ4hfzHHS1rRCkO325XrAre7STMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7938
X-OriginatorOrg: intel.com

Hi Drew,

Apologies, my reply ended up in the wrong version of this series. Please consider this as a reply to v4.
ok with me if you respond in v4.

Reinette

On 7/7/26 11:18 AM, Reinette Chatre wrote:
> Hi Drew,
> 
> On 6/28/26 2:18 PM, Drew Fustini wrote:
> 
> ...> diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_capacity.c
>> new file mode 100644
>> index 000000000000..2172432eb328
>> --- /dev/null
>> +++ b/drivers/resctrl/cbqri_capacity.c
> 
> ...
> 
>> +static int cbqri_capacity_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct cbqri_controller_info info = {};
>> +	struct device_node *cache_np;
>> +	cpumask_var_t cpu_mask;
>> +	struct resource *res;
>> +	u32 rcid_count, cache_level;
>> +	int cache_id, cpu, ret;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -EINVAL;
>> +
>> +	ret = of_property_read_u32(dev->of_node, "riscv,cbqri-rcid", &rcid_count);
>> +	if (ret) {
>> +		dev_err(dev, "missing riscv,cbqri-rcid\n");
>> +		return ret;
>> +	}
>> +
>> +	cache_np = of_parse_phandle(dev->of_node, "riscv,cbqri-cache", 0);
>> +	if (!cache_np) {
>> +		dev_err(dev, "missing riscv,cbqri-cache phandle\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = of_property_read_u32(cache_np, "cache-level", &cache_level);
>> +	if (ret) {
>> +		dev_err(dev, "%pOF: missing cache-level\n", cache_np);
>> +		goto out_put;
>> +	}
>> +
>> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
>> +		ret = -ENOMEM;
>> +		goto out_put;
>> +	}
>> +
>> +	/*
>> +	 * Associate the controller with its cache instance via
>> +	 * cacheinfo. The matching cache provides the cache id and the
>> +	 * set of harts that share the cache.
>> +	 */
>> +	cache_id = -1;
>> +	cpus_read_lock();
>> +	for_each_online_cpu(cpu) {
>> +		struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, cache_level);
>> +
>> +		if (ci && ci->fw_token == cache_np) {
>> +			cache_id = ci->id;
>> +			cpumask_copy(cpu_mask, &ci->shared_cpu_map);
> 
> The way I understand cacheinfo::shared_cpu_map is that it only contains the online
> CPUs that share the cache with this CPU and if the CPU is offline then shared_cpu_map
> only contains the CPU self.
> 
> It is thus not clear to me that this handles all the possible CPU online vs offline
> scenarios. For example, if all or some CPUs of a domain are offline during cbqri_capacity_probe()
> and then come online later. It is not clear to me whether cbqri_controller_info::cache_id,
> cbqri_controller::cache_controller::cache_id, or cbqri_controller::cache_controller::cpu_mask
> are needed. Could the cache ID associated with a CPU at the time it comes online to dynamically
> associate it with the resctrl domain that is indexed by the cache ID? This may simplify a couple
> of flows.
> 
>> +			break;
>> +		}
>> +	}
>> +	cpus_read_unlock();
>> +
>> +	if (cache_id < 0) {
>> +		dev_err(dev, "%pOF: no online hart reports an L%u cache for this node\n",
>> +			cache_np, cache_level);
>> +		ret = -ENODEV;
>> +		goto out_free;
>> +	}
>> +
>> +	info.type = CBQRI_CONTROLLER_TYPE_CAPACITY;
>> +	info.addr = res->start;
>> +	info.size = resource_size(res);
>> +	info.rcid_count = rcid_count;
>> +	info.cache_id = cache_id;
>> +
>> +	ret = riscv_cbqri_register_cc_dt(&info, cache_level, cpu_mask);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register capacity controller: %d\n", ret);
>> +		goto out_free;
>> +	}
>> +
>> +	dev_info(dev, "registered L%u capacity controller at %pa (cache_id=%d, rcid=%u)\n",
>> +		 cache_level, &info.addr, cache_id, rcid_count);
>> +
>> +out_free:
>> +	free_cpumask_var(cpu_mask);
>> +out_put:
>> +	of_node_put(cache_np);
>> +	return ret;
>> +}
> Reinette
> 

