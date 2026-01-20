Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022117.outbound.protection.outlook.com [52.101.48.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA7B3E95BB
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947904; cv=fail; b=p1TBRYc+ZHMtUKbDeCaJvehHYyhtY0lHkpz79rGE7a/zDYEvAd2ycvlDTmdPJplcNfcaESdFHj72Od0UBLkGlnIUfxjzeUmfdQAyB30CO12PrGsGG5w+FImNCFWt1Kq7gX6+HExEQF81RO1bJRdnhA6HsW2pFSY+8sz+axGzgpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947904; c=relaxed/simple;
	bh=0QE+ZUhPBaXa+rJTOJQowiWZwID01P0y8we3UGAH/3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e3f5dyhFhi5STSb17OQv2Avg9y8bEWtxmMvb06vdhXsJa1fSql4MSeTAw4UWAn09NHD8ow/yKOEaa+TjiTj2tLoNgmtKFK+Ko1hx9YQwbJ9Luc+xs0EyFf4NN55yygxyom85M4jBLN2BUXZXT8pi6jRpF2jS9bD5vNtaH/XUmVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=evs955Tj; arc=fail smtp.client-ip=52.101.48.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="evs955Tj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTRHsL5cKaEx3xS4/KndwLpd1eaCtl1N1SEp5EWV3kVM2zT6v6toIicO5WxkCRoMmABSCLtjLc4dz4OrvRSkFPOe1piNSgDRSL4hs6hDu0tq/T5AEtxIhjr0gCH+JTYK8X7UfJrWYnTHOJ9VxHuA6PWg9kFq/sXqJeQjvitIJ1956QKaVOQ8vxrJ5/JQH9NP4GYDcy/jCk5MxOlHVu7edDpTWRIKmMXQdJrJcA9gHjcvWJhdeEfV2lGFD+sgx/cXhOKohxU9FmCDnXmoVhoH5GYyfmEKkg51Glsfxm0FFAnKIP8enQ0AxWuTu4MCBTaDSDM7q36kcpG7nf4pwhamSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLPZYuFAbZIqGg5wvlmzIVC5QdtT5iknzKGfuRXnwrg=;
 b=Pk0UqlitGzegwWLZzFRhaROQkrkKiDKRz7Vz21+0scMjro7Ad5ToTb6gCpDpjQxLMO3CBvaa7h+2w9nr6cFko+SbSlohEnttPgd+O2G7JVOYXztLAxH64socaS1VBOX6R0vpde8oeQ+KmbChwG88vEVy90wZQqieuzFk2h1eT9NDbc+/GGTEZnii0kP7gzj+R7gEIRQZhbj4eeR/ck47ZSHWCcDplGLmi5ODNCZ0spWvGh509qfmBozwFwNFua/WYw8BIQwnuFZv//E2BSMysNgLCm2zs0tF6x5wEntys+tKPteWZKuND3Wm+qh5UHU4wsby2u2IBlxyVeF9SzQ5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLPZYuFAbZIqGg5wvlmzIVC5QdtT5iknzKGfuRXnwrg=;
 b=evs955TjR0X3GrjSzCmHEepFOaunh95TCQterruaecvJ46vYI+Nh90tz+PcYxuMgfHucoZqwyC7Cku2adgmnytJ0CEzch5uO1BCqctnSTa7F3qNGFDlVcG9UFp9c2IONSVOBbiDIjNzorkdNroFj2oczIpjiAqgO18SpP8Z/kHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 CO1PR01MB8916.prod.exchangelabs.com (2603:10b6:303:26f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.6; Tue, 20 Jan 2026 22:24:54 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::91fc:9877:8a2a:d4e0%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 22:24:53 +0000
Message-ID: <5a5c78a4-0b07-4337-8b31-a2cdce1834ea@os.amperecomputing.com>
Date: Tue, 20 Jan 2026 14:24:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while splitting
 the linear mapping
To: Yeoreum Yun <yeoreum.yun@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 chaitanyas.prakash@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 jackmanb@google.com, vbabka@suse.cz, mhocko@suse.com
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck> <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <aW9LCX92T9t8iDco@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:930:8c::17) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|CO1PR01MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d522c5-bb17-4787-8a30-08de5872ba95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUdveHgxdmxnWHlWaTJkYWpLSW1nT25zRjVPMEl6QnZCUjlmS0NsWVBjVXdE?=
 =?utf-8?B?dDFvM2U1M3ZRUWF1K0piTFhHSGZGWURCcVZXemx4MVdqbHBIYnIvTjlDTlZX?=
 =?utf-8?B?YXZ1OE00aWRUemk2YkV1VFJ4TFRhSnZMWWFwb0FSVjd5S3RGcVBmUjJReUFZ?=
 =?utf-8?B?N3lVZUxESTJ3aU5JZmFEWkVoNjl2WUhxcThxQmp1RjIrUG51UTlsOWp4VFJZ?=
 =?utf-8?B?ZG4xTlRpeWJtYU1ZU2JuUU9wS012OVExTXJQb3cvbkVlU3hvMU9JbENDSXJv?=
 =?utf-8?B?NE1RYStzMFcrdTNCM2VFM3ZIek5ZNGpQYVcrZVRLVHdLNlMySnhjNUxyMWJY?=
 =?utf-8?B?M1V4cnRPOUZkdXZUR3h6S0JuUDhzdmV5MWc0QjE0NkVWUFhiRXlneTYvTUFv?=
 =?utf-8?B?VnpIcHp3WTRVdjZEbVJVbVMwcDNUclJGTkZkS1BDNEtXeFpSS2VveVJaRWhu?=
 =?utf-8?B?UjVsNUNtZldIOThhU2ZnU2piS3U2RkVtYzlDWG1PVmI0OGFRNWJ5TzdyM3pP?=
 =?utf-8?B?N0VDZXRhcGUxdTkyQWwxVmMvK1MvZ3hLSmRmUmJhNmdBY05qQVBVMDNxRXN5?=
 =?utf-8?B?ekdBM0JFT3JFdEFJTU9pSFoxN3FMZkZsZUJBenRuZVBBOFlVUU95b2hML1gv?=
 =?utf-8?B?S2ZUVUtuVlhDY3d6aHI3aTdJaUJCVEdGMFBKNjQrT3AwNkhQMTR4bDZkbUlX?=
 =?utf-8?B?Y3p6Zkt0VnpDV0dtYVB3dWRLWXZqblBRS0ZwK1R6TzlkeEE4eDRNWDVUdkNT?=
 =?utf-8?B?cDRIeW1ValRTdnQ5bk0vN3RMZmZjOG8xVTJJc25UejNTUnVVYXA0Y1lpWkNh?=
 =?utf-8?B?eERYOFdPTE1pTU02dkM4Yzh2SnlZQTRBTytTWHRJRFpvNUpLUE1xaGJ6SVVh?=
 =?utf-8?B?VXBKamxNMDMxQWNkdmdsc0dhVUc1RWFrVHJvbC85LzlTWDlMVXkrTHR3NytO?=
 =?utf-8?B?REtPL28wM201ajBTbmRwMXdjQlBIYU9tWERJV0ZUaEZqVlFsb0VtUituNG04?=
 =?utf-8?B?NjdvRy9UWFhZUlhIZWtFZGRYOExkWXVURmVhY2pia0Z3bUFBaURMQk9nd2xz?=
 =?utf-8?B?bWkrNUxpUzlKZ0pUQnQ1VGRsamx1bGduWFZPbFQ3VXhKeWtmZ0tjdjFDVHJR?=
 =?utf-8?B?VlR6UmxWTzVUVWhtYjNBblRmSkNrOEJSS2VjZlB4ZWJzMHZEUnRrV0dyWit4?=
 =?utf-8?B?TWUzUWRTMVRGMGI1Q2VBNllxMjhMRTJhL0I0RE5RN2VLMlVJK1dCWVVHR3Vs?=
 =?utf-8?B?cEZLeGNoSjFhQlBpNVJHR0QvSGZ3cldrN1FQeWRDNWhrUWdlM1ZjWUZORThL?=
 =?utf-8?B?Rm1tZ2J2akJndGo1NGJHaUhiZEY5SzljZ0FvWXk2enQ0N2hkR3gzZHVLNEJi?=
 =?utf-8?B?U2UyeWZjNDhFQlJocnBRT1dNMGxxRzROc25BMVUzRDZleE4xKzZ0Rkp0SWFt?=
 =?utf-8?B?TUZ2Q0o0WTYzRFFocDlYU282bUhiaDY5VEVNRkZmckNpTzJ3QzVaR3FSNlZT?=
 =?utf-8?B?V1JrOFMwN29yR05sN2o5RzJrQVRlRjFTR1F4dDdSREN3dlBXRjhqUDlwQStB?=
 =?utf-8?B?SzNrazBzOVhhVzI1UVluMTc0TXhRTCtxL3dMcm9xSlpBdWVIVFZQbWNkcE9m?=
 =?utf-8?B?cEh3OCtMWG56eGM1b2lSaEtLZXlNbnJQRFVrQ2xaWk50QnBCeStweXNDZmMr?=
 =?utf-8?B?Q1AvRU9LRU84eklqcFlzOVUvckNEbEZWMHlaalgyaWFNQS9DTkFuVk9KSW5P?=
 =?utf-8?B?ZVFUV0dRUHNUK1hkTWc1TklyUnlFdDdxQWpieEtoU01tWkxSNzRyc3JJejFR?=
 =?utf-8?B?MmxlaUp1RmVxMzl4WnMzZ3ZDUHFjTzdYK1NuUVByZCtlQnJjeE82MjloWkZl?=
 =?utf-8?B?emFTcGFQYVpxbUNvcW9sU0tmRWV5S0U1bzMvVjJwVGxlY3B3RVpFRSsxbkNQ?=
 =?utf-8?B?eGJiR0NDZllvTXduQmx2WVpQQUsxTFhtamlZS1VrdDFiMG9td2tYaSsvOE5Z?=
 =?utf-8?B?U1M2OVR2cmFDOG9tdHpaTjBRaEtoaEoyeVJoMXZDYlZPa25rMlFiR1JiTnVL?=
 =?utf-8?B?UFM0ZU5sZ1R3dVRQMGhBUzZMdXJ0dXFmZzQwS2xDSjJSdUltSXNkcjlsSUlp?=
 =?utf-8?Q?QPHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEJRamRKS2hQcVZqWlBiSjc2WjV0ZUpLdjVKWmFVVHI0R0ZpQ2ZrMHBZMHlJ?=
 =?utf-8?B?NUtFUXlPWWZxZ1g3dVAzMHFWRmdyOVQxR0toLzhtZEI1Y08xUDZBUE0wcHRR?=
 =?utf-8?B?enkzbGVTNXphbTAwKy9oWWFKZWUxb2FOQ1pRemduMVlHQ0xCVlpwR3h1QVkr?=
 =?utf-8?B?SXI2cmJES3gzd3UyNzU3REd4VkFkeXp4ZE42bW9yRzZlVGQrdWQ5bWZxZk9r?=
 =?utf-8?B?cjVpNUliVmZBUlVkNDQ4VDJXVmc3UVBkTjdmczlLN1dGS2ZwaFhVZFV0SFZl?=
 =?utf-8?B?U0VscExkTFlMNTdpT0NRWHl6MzVNb0lRdzFjNytnS1VKL1UrRjhnMGpuZE9n?=
 =?utf-8?B?c0dRdkpqU2RhbXVuWHN1czFBL255cUFpYWNLRWlHTjd1VWZMakh5RFVIcGc3?=
 =?utf-8?B?eHBYeXhhVmV6dTNPeXBzMU45N3lxVjBWenV1eWpJQlU5MFAxbHZiZnNWM2hk?=
 =?utf-8?B?VENCczBRZmZ1OFR0Y3hwazAyeWhXOGlKQVpYUmZVejhQNmxDTjM4bkJ2eWZ0?=
 =?utf-8?B?SGFPOExqcFlaWEZEV0RLRE93MHFxeThlTC9tTmgxYVdQNHdwZVNDbFJselpP?=
 =?utf-8?B?WnNPbGNSRjJURC94djdjWkVoY2tYSW1NaGEyUTNqbFRxV0ZuSnZjdE8rV1h1?=
 =?utf-8?B?NVhjTkM4ZFR5bnVsQkorWDAxakpIcExRcUZhRW5lcUJYWUt6TEtFbUVCa09n?=
 =?utf-8?B?U3NUZFBPNlhvVkxMZHhyRzhjWnBtK3ZpM2JMTmlQWllBemZyQXNaZ2c0VldK?=
 =?utf-8?B?V0tuVGtlUkVRcVFuZkZ5TUYwNjVtWXc4dmdDNHNUbVpGd051V2FvaGxTN0s3?=
 =?utf-8?B?Q1BwczNINUtlZWRvQTR0R1V5K2dnaHpEcGFlczJmbHpVNDdLVml1bXJHRmt1?=
 =?utf-8?B?ay9sZ2FNd212MFB2cGJEQzdEWStNNCtNTEoxQSsxK0RubGVZUGE3cWVtdHpr?=
 =?utf-8?B?OUtid1FCRXVKazBCZFhFT1MzRml0Rnh5SkI2T2JJeC9SSW5BU3VnY0xhN1ps?=
 =?utf-8?B?aktkRkJDTWMzc0NqOUw5YkRiejE3RlNmY3ZEaFdRSEVSc1BtVEtJaFJjZlRV?=
 =?utf-8?B?a2RUMUp1Z3hibU40UmxFdVQ1WitXTU96TFh0My8xOFRieGFoVXQwY2FWbnBj?=
 =?utf-8?B?TmUzNzJDQlE0T1N1b242VlNlc3YvMXc5VTE4eUhnMkZockJQei9BTndzOEFv?=
 =?utf-8?B?R0hvSldKNU84MDJJQUF0M3A1eTVRYWJoNG5hTDFGSnNQOGdlNUJibU1FaGdH?=
 =?utf-8?B?eHRhbTJ3NllaRWd3M2xINjVkZEdvdkFaZ09qazB5QzhHblByeWh5MTBKTzhQ?=
 =?utf-8?B?dUFTay92WTdqK1dZWkpkanVKdE1Zb0FQekJKWWVNNWlzNDFPUStxNlNqdFVN?=
 =?utf-8?B?SDFmZis3dUc1NDJzZ2gvRndTT2FSM2p5a3JXekNhejJRWk1QL3BjMzhtNm1B?=
 =?utf-8?B?d1c4V24vd2NaN3V3dkQ3U1BkRVh3anZYL2R5RlkxTTVoaXArM0VvYjhQWGdP?=
 =?utf-8?B?RlY1Nk9VL01tMFFvWnAzY0prbkJqMWY3SjBhRkMyMWxvSmhndzJVZUQ0SmlE?=
 =?utf-8?B?RDRPc3RZZHpKNmc5REcwS2IzYnVJL1JYNXJLbWFMV2c2LzEwNHdmb0M4ekxD?=
 =?utf-8?B?N213b0tabXFma1JleWFlcjVmRkJGQTFVa2RaemFadDVFNmgzSVZuemMxenlU?=
 =?utf-8?B?dWkremVrZHlJWkhsekJ6T05WS0lUcDV1ZUIyRUNwOG1QWi9qa3ZzRjJYckVZ?=
 =?utf-8?B?QytXbEJNTWRrVzBSUnJFeWJld2lUUkhkVEJGV2FrT2wvakFMb2FxZDZDdlQw?=
 =?utf-8?B?SmJPTjdNY0ZLMjBxS3BJL2tTV1lVRU9ZWlp4TlpBaTBCbEZnNUtsMzNFdnFl?=
 =?utf-8?B?NUcxWjViZk9iakEyQzcvb1RlOXNzTCsyYlE3bWhxc09NYnE1RWhlSnZ2VzVh?=
 =?utf-8?B?NkgwdlNaRERwWlY0MTA1SUZuOUZqVVE4SGU3cVJGNDhUK1h6am5rZE5JM3Fw?=
 =?utf-8?B?L1R4TDVDS0pmTyt6bXdjT2puMGFncXNDZ09CRHJ1NFJCUkVEVWhXZXNtQkRy?=
 =?utf-8?B?ckVsOWVUeC9iWGJxNzBheWd2WjlZYzZYM1FzMmlyVkE4SWE0T1U5Vld6RTlC?=
 =?utf-8?B?ODV3MFZSWnZGWUJvN0RqWTlqMDR4QUJaZmpGV0J2dk8rUDFKRVVUVFVnQ3lH?=
 =?utf-8?B?cUJJUWFSV3JNQU9DM2ppNG9pOW9Zc1BKcStQSHdaU0tIN2J4ajFjbXV0THQy?=
 =?utf-8?B?aG1DREl5N29vZEhDQkZURFh0MmsrLzdENUVVaHhGbndPWW8yMjZibllIT2py?=
 =?utf-8?B?bGJlM2trU3JaTXo1K3NYTVRQaTJXY25ZaG5TZExYMzFrY0hJRVAxU1UyZDZX?=
 =?utf-8?Q?eJu9dJkoDYD2l4J4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d522c5-bb17-4787-8a30-08de5872ba95
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:24:53.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjeQqPXRiEy8aEN4sSD0Y0YjjRdSjgLqPvajFO3kvkyScdxigUdWrLk97XiPla6tWSlGERCHSz29QTCg38ioxMoRH3qIiT2FKzgrpaTrhK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8916



On 1/20/26 1:29 AM, Yeoreum Yun wrote:
> Hi Ryan
>> On 19/01/2026 21:24, Yeoreum Yun wrote:
>>> Hi Will,
>>>
>>>> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
>>>>> +static int __init linear_map_prealloc_split_pgtables(void)
>>>>> +{
>>>>> +	int ret, i;
>>>>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
>>>>> +	unsigned long lend = PAGE_END;
>>>>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
>>>>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
>>>>> +
>>>>> +	const struct mm_walk_ops collect_to_split_ops = {
>>>>> +		.pud_entry	= collect_to_split_pud_entry,
>>>>> +		.pmd_entry	= collect_to_split_pmd_entry
>>>>> +	};
>>>> Why do we need to rewalk the page-table here instead of collating the
>>>> number of block mappings we put down when creating the linear map in
>>>> the first place?
>> That's a good point; perhaps we can reuse the counters that this series introduces?
>>
>> https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/

Yeah, good point. It seems feasible to me. The patch can count how many 
PUD/CONT_PMD/PMD mappings, we can calculate how many page table pages 
need to be allocated based on those counters.

>>
>>> First, linear alias of the [_text, __init_begin) is not a target for
>>> the split and it also seems strange to me to add code inside alloc_init_XXX()
>>> that both checks an address range and counts to get the number of block mappings.

IIUC, it should be not that hard to exclude kernel mappings. We know 
kernel_start and kernel_end, so you should be able to maintain a set of 
counters for kernel, then minus them when you do the calculation for how 
many page table pages need to be allocated.

>>>
>>> Second, for a future feature,
>>> I hope to add some code to split "specfic" area to be spilt e.x)
>>> to set a specific pkey for specific area.
>> Could you give more detail on this? My working assumption is that either the
>> system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
>> linear map. If it does, we already have logic to split parts of the linear map
>> when needed.
> This is not for a linear mapping case. but for a "kernel text area".
> As a draft, I want to mark some of kernel code can executable
> both kernel and eBPF program.
> (I'm trying to make eBPF program non-executable kernel code directly
> with POE feature).
> For this "executable area" both of kernel and eBPF program
> -- typical example is exception entry, It need to split that specific
> range and mark them with special POE index.

IIUC, you want to change POE attributes for some kernel area (mainly in 
vmalloc address space). It sounds like you can do something like 
set_memory_rox(), but just split vmalloc address mapping instead of 
linear mapping. Or you need preallocate page table pages in this case? 
Anyway we can have more simple way to count block mappings for splitting 
linear mapping, it seems not necessary to re-walk page table again IMHO.

Thanks,
Yang

>
>>> In this case, it's useful to rewalk the page-table with the specific
>>> range to get the number of block mapping.
>>>
>>>>> +	split_pgtables_idx = 0;
>>>>> +	split_pgtables_count = 0;
>>>>> +
>>>>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
>>>>> +						    &collect_to_split_ops,
>>>>> +						    NULL, NULL);
>>>>> +	if (!ret)
>>>>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
>>>>> +							    &collect_to_split_ops,
>>>>> +							    NULL, NULL);
>>>>> +	if (ret || !split_pgtables_count)
>>>>> +		goto error;
>>>>> +
>>>>> +	ret = -ENOMEM;
>>>>> +
>>>>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
>>>>> +				  GFP_KERNEL | __GFP_ZERO);
>>>>> +	if (!split_pgtables)
>>>>> +		goto error;
>>>>> +
>>>>> +	for (i = 0; i < split_pgtables_count; i++) {
>>>>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
>>>>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
>>>>> +		if (!split_pgtables[i])
>>>>> +			goto error;
>>>> This looks potentially expensive on the boot path and only gets worse as
>>>> the amount of memory grows. Maybe we should predicate this preallocation
>>>> on preempt-rt?
>>> Agree. then I'll apply pre-allocation with PREEMPT_RT only.
>> I guess I'm missing something obvious but I don't understand the problem here...
>> We are only deferring the allocation of all these pgtables, so the cost is
>> neutral surely? Had we correctly guessed that the system doesn't support BBML2
>> earlier, we would have had to allocate all these pgtables earlier.
>>
>> Another way to look at it is that we are still allocating the same number of
>> pgtables in the existing fallback path, it's just that we are doing it inside
>> the stop_machine().
>>
>> My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
>> with significantly less testing...
> IIUC, Will's mention is additional memory allocation for
> "split_pgtables" where saved "pre-allocate" page tables.
> As the memory increase, definitely this size would increase the cost.
>
> And this cost need not to burden for !PREEMPT_RT since
> it can use memory allocation in stop_machine() with GFP_ATOMIC.
>
> But I also agree in the aspect that if that cost not much of huge,
> It's also convincing and additionally, as I mentioned in another thread,
> It would be good not to give a hallucination GFP_ATOMIC is fine for
> everywhere even in the PREEMPT_RT.
>
> --
> Sincerely,
> Yeoreum Yun

