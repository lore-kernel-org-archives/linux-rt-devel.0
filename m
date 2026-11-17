Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.87
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924965;
	b=0nw/hCYBbPe5xm20gBFUBzGyOSU10HUBJrHKw7oBWL9+9RC83FtqPS9Y8aorQqzkQY/0
	 XnbEX97LI/aiYatNEFkL78vE0MSDQADxM4rBq2nMHQJoOCi+FpEvXAM1Dm0AVwIq3pB7k
	 zF+UWyPOEqC9GFnk58Q/Pjdi/6lpXlYfRtAiij++IUipJNDQgsTcbMMgdbvYMLpurLKLN
	 yJ6crnVXr3ovzC6DcyIo90Upgt/tmDucTmnzveg8lbhwrstbrSfOQ8R1ppaQOeVNDyBFb
	 6/AGO7vWSqMj+fR489JgNwcqphSZC80L2Paf4Y4wXSWvi/Jv39aPkkKipxZXg4Oni4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924965;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rJP4mSVEK2s1WQ2xmK5MUOYVucWgxPYZPxn+VFA2xbk=;
	b=nFYaByvrPcTI08bqOws/LkpzLSXXn6/G4eDADh0IBsovhBtLNJTYwWfZMsUVmDg0vsQ/
	 OSdxY492TZt9MDbAXRYn18brXRfwZUsVOtZl42eTszbGmyiYpE02/rlvisAn9Bx+5CMdC
	 O0esZVcl4yS/7RggT6+zNt5zEzth8iuoipSSfT0HvpRdUwslCQmOc/uBoA06Rd5+kAYT9
	 6aIIv8a9NyHuoVaWaiAk3UXwtQBsxpPrcN8ssgUwSGyH+7rEiNxe5Krwuksa5fdngHi0G
	 /Q7fFJF4IEQvsgN4X2Y6Fn8zaNyWy1+0ytPO9vH4alKwGlvwuKJC3g6ksx/3tvUS5cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="JFb/iGY1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.87
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020087.outbound.protection.outlook.com [52.101.191.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070A606A8AA;
	Tue, 17 Nov 2026 14:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4070A606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=JFb/iGY1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhXGy4dSnlwvq6px0skSl16mgnZ5v/ouH907sFmC0sQzOTG+OEsPA01pWx8IjmD0avwqKQBf3qVlBml0sfLBvd3SaICmaWOr3Tt1PDwRP0UacrNB7jtMCDKDlAw4p/nRqtfRS5bK6OUhfvbwpMfnGTIJnUiPYkc5IFfxibWyYOTPNk3VyvVendZIJlA8mnGQuK5LeFAOI7UZUMmceWeAz4djttHWmVHwko0pvYsEJWQ43mdmZfTeKqAV5JZlCZZM2uWitHGxfTtZ3kA/Geg7momX8yuKUZdl/14e8HqjaxVnDaJ7gyxR7cu9Tt6m8MNM7si/rx9APRqCx6icGj4dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJP4mSVEK2s1WQ2xmK5MUOYVucWgxPYZPxn+VFA2xbk=;
 b=nYllvXcM9c6TJ0uHLq/3ixhvkcEsSFTy1M4p63ea2JCdq9LtHqDijTlcBacowUax+Xsn6NvehNV3RWFZenNQl7Cbi91SlPZExblpnkoPLdyjJ19zVSV5dZrSbRX71pYCC9hLFHEsxx49DizKViZ59IDv4lyiUCEuOUcNuVKEx/YTTH0M/tvzVbcG9Eeq3YUZMuyHZ2EN+3iKdyaIFF0/paCsZNHq4/whrL2VYVfBPOetHgAxvntrc4+r/Tct+o8WKfgI6lO8oP+fQ+SShrhgQpmFHNGBbzhiSKJID74hnauguqQoC7kyB8r9wntdn9tHklmqOrBKVLjr+MoZZSOm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJP4mSVEK2s1WQ2xmK5MUOYVucWgxPYZPxn+VFA2xbk=;
 b=JFb/iGY1H7ISTSbRb+yw473ULJTINnycPvsvM0x5UatTtbrGCrp9iYAHubjcbvjWq1EQOx8AWBb/y5Nsn0PrrPa6Tv/geHKnzbIcsul2b2jlRNrkhEOywFjMC2p2LtAqhtrkxMBw4DoCXo/CW8i33KVLnL0T6pkqMoDpOr5OtAvGkuzaDPOaP4dBdQQEsFyUJ8SQyMdhgiOtbGy9WjAlHqjTaY7HFBHxnCA/1HfHPyZQ9P8giPkoQGdLou+q4n7FABwQnderSHRIgbV2mLjSah5nk0ao0kjtTFDXlL7OOfsvp1/f7/XRfDvdx3URgMJHFikPL6d4gPv2ZsibOg/6xw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB10281.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:15:59 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:15:59 +0000
Message-ID: <b2b9ed9b-3db6-4043-865d-8d79c7ef8d06@efficios.com>
Date: Tue, 17 Nov 2026 09:15:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/37] sched/deadline: Record the root domain holding a
 task's bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-17-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-217599@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-217599@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::15) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB10281:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdfa6c9-4d55-425f-4c69-08df44b54d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|3023799007|4143699003|5023799004|56012099006|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	1QzJUfxqmEjb/yEcuHyx/BgGaDLb/eUaG6icE3MsIbd6auE+Wr+tW5xV1cOsL6O6B+yVS5dlgzAReEH5Qg+ORFUoXVRABxMpXkSylvXWwEeWWFkJtS8PD0LZIH8YjAU7EpDbz7jv7321uhzJ7hgwC/eXZpjTLKEb1bOR8iVIAhojwoZBPhyl9LH6zNY6oiS21fhfxceP24IpbPOBMgxuQFSqk7IFvm4wUUz0s6Ao4MWZjAwjS9qk+86ErsNAkhR/L0vDpTIRVYoZ1+b8NlYj16151AUy3ugYuGmqpGUhLuXwgQQ8HxQfAX1Lfr3aZHNi6X1J7TZByRdvwE3G9YRPUaxQpbds7sEMG12oQ3LZBPt82EeTEX5hcsFhAbNrnLaAPC+tCLhjXbqog0H0FlkuWws0cIzqhtHZMmjrI9VtWdl4lcGy9NkTKH4ZRGQO37kVv4ORK/e2bNQUtBNFcu8Sw7kKF71kJoclbYJvS5K8rUf6MfxDBqvWYCPASz4B2XY+QAhJf+G+FeUPMaIIsnGUGX2TWXKnl7FMNkbtJXsnfh2B8LbbdS4HMNDPLpTGxAY13f/seT1RdiS1gWxIrvCfFDXipXLXUflize1JjccrpNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(4143699003)(5023799004)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a25oZEJuWS9lWGxYWGV1Y3lyQ1BJL3UxR1U1SE5GS2hoZ3ZHT0NDdEhrRzND?=
 =?utf-8?B?RTVpeXFQL3d2bDBJNGVzNzY4bVFUZjVMRXdNRy9JQ1RVY0RGWDJpMGZpcDdZ?=
 =?utf-8?B?NEowNFA5L3lWK3VFR0JEUnpkNTkyQmR1NmJSMDRMWkNxbzgzSWxaQ0ZKMHJW?=
 =?utf-8?B?QjVqWXhwYlZadWF4TkNNWDROZ2VHRk84aGNVYlE3QkJnSEd0Zkp2ZUVGUTV3?=
 =?utf-8?B?ZmhjYkkvQzVHTmVQVU8ya3lUZm03SVduR2pTVXFGYTU5NXZkRXFTc1h4eVlP?=
 =?utf-8?B?Q2FUOFpQdkpiTG9DOFZQMmVzR1l1L0JSekdRYTIrYUhZa1NPZzZzb3lJSmMy?=
 =?utf-8?B?VWIvekE5WVRPN21wb0tMU1Z6djlSeFpveHN3Kyt5QzF3ZFJZNVQ5SWhySUNt?=
 =?utf-8?B?aTFCTVFqci8rdTBKY3A1UitqV1RDVU9HNkhINXpSNEtBOTlJd0FXbVk5NWUv?=
 =?utf-8?B?NHlOYjN4V2w1Vk1kY2RLdFRHR3h4c1lnYXNTRmxwdHZ1OHlkZ1ZyVlBneThB?=
 =?utf-8?B?Znl1SUFCdTBzQXdsYlM0Z2hEakhLeElMOE5ldDNseWtmek5EUVRpNStINzl1?=
 =?utf-8?B?c05SMUZvcUdTY0hBZWhNTFhJUysrbkZQRTBhRWdDazd6dnlwNytWRmFYY1cz?=
 =?utf-8?B?dy9yUGZVL1plYlltdTdLSSsxQWNuS2lyYUxkcWxablZiOWZDLytXc3hKNWZh?=
 =?utf-8?B?L3gzamRGT0ZXVnMrOTVKM25IamF0MzY0cGI5NERWYUV1TCtPc2J5MjRoVXB6?=
 =?utf-8?B?Wjl1enQrVUF5UWltWWJtRVV5anZoY2F5MlN5Uk9GZDJ6bVkxZ2xwbFRHdTRt?=
 =?utf-8?B?R2ZlZURuWnloTEpnOEFnbEI3blZhVE8ySHpIUm1sV1Z6RzNqeFFkWHBGQVdR?=
 =?utf-8?B?dXl3WlpYc3J1N2l6WHlNKzJNZ0ZLMkJIdUYvZWdrOVg4ZTRhU3FnckxHZGs2?=
 =?utf-8?B?b1BYWlpOaVdydnJFdGd1aENGWG91TVJzUFlIQlR0dVUwekdFNDJ2bkt5QWtB?=
 =?utf-8?B?QU9ZTWZnRXk2QjdDOTgyRWlnd2xrZmQyZm4wbzlRMnFHcW5uU2g2MGpId2ZE?=
 =?utf-8?B?cE5pNEZXMlBuNHJoMmw0UnhjRitiUHRCTGVUcnpRWVVUTkd0UjBZU0tVc1Rw?=
 =?utf-8?B?d2lydEJva2VxRGpBRWloaW9pOG9VTG1naFVuYisyZ0VYQlE0TlpscWQvTURz?=
 =?utf-8?B?NHBtSnA2UWt5WW9meEtxM3lKUFI5K0dBWWREWk4zRkQ4cEZOSUJIU3hocXVa?=
 =?utf-8?B?TFBrZzRUL0V3eENPYmlMQUdldlZRalVxQmJ5c2hCaFdLakJmdjhPN25nSmxw?=
 =?utf-8?B?ZlNRNVJuUUF5Nko1TGJ1QkJxQXZxTXZUZmg0M2tiMWVsU1RLZGtka0VxTjJE?=
 =?utf-8?B?K2oxMit4ZGpBN1JUcVE4dXVrQkRzSGRKd0hjNW42RGhmWVpvMzl1ZXdGNmQ2?=
 =?utf-8?B?RVNWMW02T2tzM2ZmSHRxZjVXL0pva3ZCdHRtOWVHY3ZQbUxlTVhjTmFNZzZa?=
 =?utf-8?B?QWMxZW03ekllUmVXT0orcW93cmZuakxxNGx5Q2ZXN2s3cWh1b3FPc1Z2aG16?=
 =?utf-8?B?S2pIZW50S0RMd1NoQUpDek5STWVQK0hCZ3RhWkEzb0g0MC9CcG9pcGZXbnNT?=
 =?utf-8?B?RnZsanlJODl3MW1IbnNxb1BiTkxhc240WFRWRmxTczNCM1JaZEZWMjIzbVFa?=
 =?utf-8?B?TTRJTWtQQ1lrYU55Vk5YMk94WU55QTRVZXFHWm52ZmZKVk1oN3l1bFV1dGQz?=
 =?utf-8?B?eDliVGwzRlc5N0F5OGhrSnQ3MlQ5OEZqQWpqVktXTlBlekpQOG9rNk12czFp?=
 =?utf-8?B?UlZsZ2ROcnN0bmNmZ1hvWEEwSzkya2p2UTB1WUhVMDJkM2p6ajZ3SW9Nalk1?=
 =?utf-8?B?SDRPdVNaY0pqUmlBS1RabTF1YVRQbFdLNUkwSXJYS1RSUFFVZDgrOEp0U0d0?=
 =?utf-8?B?TVNHcUpHS2V0Slpwb1p5YnFpc2hQVEtubmFnM3BYYTUvUFE4aUt6Uk4zZGU4?=
 =?utf-8?B?RGNxb2Jxb245dFhLUDhSNWtpTjRoOCsveTRCUTVDODZkc1lnaUVaTDJ1NUpm?=
 =?utf-8?B?Ukd1WjRiWDl6QUFXM3NIVHhIN1NvSWxYY25nak1tNWZITk12Tk9wWThidG90?=
 =?utf-8?B?eWtEa2p0aG4zREJSSUtsTWpVUHhFNUduV0RzWExEbFM0WnZ4Vk5lRkpPMkhX?=
 =?utf-8?B?WUR1azNEaU9BTFFOODdWTUVjalNqOW5lNCtOVnZLN3ViM2hZUm5NVVo2RG9R?=
 =?utf-8?B?OEU4aS9uWCtkTkh0STBHeXdEYXI3R0Z1MW4valR4dEtlQmJrWnBJYjd3Sm0w?=
 =?utf-8?B?YndXTytWSUVqQlRIdkczL1czZmVPTE5vT29HWHVMMEYvNHFDYk1seEFXMHoz?=
 =?utf-8?Q?HHCJz1xe5vQ34TV+YXoF/zu64HsNVvbPSrmlH?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdfa6c9-4d55-425f-4c69-08df44b54d9d
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:15:59.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuNzFp5IlvQEVniBbb0CFRTggp/rvWT/K8mCPwZqHY2MNm+HKzYiO2EoaDd7PZHLdIfLnmWHCvxUy+1UErkB22JnkItZi6lVn2nbL8OliXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10281

> Should __sched_setscheduler() also check the root domain of the recorded
> dl_bw_cpu instead of rq->rd?

Thanks. That EPERM is the baseline's affinity check. The cover letter
lists it under "Not changed". It refuses the call, so nothing is
counted wrongly.

The check also matters when sched_setattr() makes a task a deadline
task during a cpuset move. Patch 21 covers that case ("sched: Make
deadline policy and affinity changes wait for a cpuset attach"). That
task has no CPU recorded yet. So the root domain of the CPU it is on is
the only one the check can use.

Once the task has run on its new CPUs, its parameters can be changed as
usual.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
