Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925021;
	b=w10Us/6RWYqKcqMfHtmlaIrI58yZzxmZjnfb4nT+qrDCqkk8+rxuRtaBmQ5aiPKkpRl1
	 d3ss4jeOLljqcJW3qHb6MN7eexYleRW197AL1xSOVKogP8T1y0eloMEOfTQ4+kwPjJ7ni
	 NvSEgKFJtW8Hv0bqlShY+d3HGRytL9dYw73f7VKYt8bAh+Aanb1BQ1s98fkP5FPgeSyFe
	 3Hhr4sKFWaDlSfiwFbuRaaRtyRTFqNkFsQPf/SVlCafosZ1gZyaG3/aqyUdfTo5VAjhlp
	 QOx689ZsHDPg2kdSfUUEm8lETCmJ0FNcE44HwgkvVlNqaxukDLaXrBWUvgKD1Jb9c1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925021;
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
	bh=jQ3x9mP42SzrmhvUTH13SBizLJxWtEC4BtaOqbuFnEA=;
	b=YxBOoPW72TveBJIPw6XPE6D8ESY9ZWvUAGmBXQmiWSNBAmNrH8rtQpaJaeki2+/78qnd
	 EBz9+hCv2eLXv/GOriq/iV5ljuUbwdONEOz7anuoTEYKKrcpj3P86+XiP5j2CxGuwFz+F
	 +ZqGU00Z2nD2bbJcWhacMBZxm6TxIx5eFjAfHus6Ntkh78BEZ4ex6v3ue18ve5+U5wCaG
	 iPDxOgHNaVWAvVZ9Te3FLcO7mAtwuqoD6vDE0z8Xyv1TzAVVyS04B7TQ4ptiB2p1AL6Ri
	 Y0Sb7/Gd32wUIJA0eY2MSnIDdbxxGo0qpEBP0G1rZeJv7/A/MgBUfE779MFEqLJ454w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=l94qPOCK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.133
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020133.outbound.protection.outlook.com [52.101.191.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A13606A32F;
	Tue, 17 Nov 2026 14:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A13606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=l94qPOCK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egaMghFQ9CmfQuQgbJXrIokHia1eOTBe6vuChu0qTkTOHOEgneCEtpv0EfBprC6hEGOzjazDNIwseeeCjpszz1NW/u3aNSkuFj/Wejpyur1l9aPJy2ysD6u6/aJ6sIv0l/57HYhZWIc8TJ/J+uDmWMyRF9NnFl2foarQ+Cz3HHL9ElgcW9o3QAikvMyLR+f8Op4jvUjVpZJ/qQjdkLRGr/jSufUFV2/v5CgZBpThHmsOHC74TR5njVv7gqNYmtLVLTCguQnKI4pPguXlZMpmX/2k0c+DTl3L6MGk+ElC3pE0P1//96wqT5+lI8j4mwsxHWEGUkWjCoQ3wsnMQ4MABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ3x9mP42SzrmhvUTH13SBizLJxWtEC4BtaOqbuFnEA=;
 b=DFFngP885KE7/FRWRcKPS3ucjdTyOEAoySuizqii2SBXS/RvuFp//rItjaJS0YYYfWh9F89BnHKCK8Or+M8dE3pOEgzI3TbbuXYwsHNqAyynKVCW7J1SChpui2ZqICXt3EqyYk9fXGPPsVCs8tYpumRsN+GYM2T4WpwNVqVhqLunkzTAKcYl5gFmHlY4drWwuM161CDLCbFyOX2hXLpIvn2RZydScO2opdFfU1tlJNv9+A2oiMNjuJZ4whMlNQbe6UlvVNPSUuOtc7pc+EBonrIwRdCevDzTFqz72EjVN0dw0NXRhh80ySie5U57HNHWzcaUdkAOZqgx8MaO/xpSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ3x9mP42SzrmhvUTH13SBizLJxWtEC4BtaOqbuFnEA=;
 b=l94qPOCK+TKepM3xCg11vRAd4lMNZ8X49SmLCtpdw0aF+ZYGzbkFOMOm4lUvThqejmnfkdCM30jndCT+LbhMLvuvT0T33W/JFLkjzI8DoBXVXjx5HZ8gA9PmBUwbYsr+x+xbwqH0AW2ZTGMldQddcmPj8yDbzJ33tUaXalctqS42sSmBgG/II1vNa7gfKc+ozZCTjzUYm0tid3gS0/BuiU83Nd8IPudE7TGlSoDUR5Q4/iI/O0LFTYt58zXKo0U4NHgTb7A0DevxbVtV+byKxPBumL0sr8hMRrXaAD/xRFER/Gm9l/KOPy+tPrUigvd9YwS3OqLL1B4u5KdjHm8tHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT2PR01MB9777.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:16:59 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:16:59 +0000
Message-ID: <fe0fcbd2-96e2-4210-9838-3885cba34f35@efficios.com>
Date: Tue, 17 Nov 2026 09:16:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 26/37] sched/deadline: Keep a task in the root domain
 that counts its bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-27-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-217620@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-217620@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT2PR01MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 033b5274-d1f2-486e-8b55-08df44b57143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|56012099006|4143699003|261028144727099003|10067099003|261026140227099003|261026121527099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	huzzCPnhhfMf5yMTywQMhHwoU4pa2Nhria94Xl0k75IisPn3naae057l/R6SDER5u4cV6lvDPZVendwIIPZzzGAv3EqFPK5k9rp9Q6iGDJ9Us8ryjU70Sid9IpqdQQphgTwOZAnQHMYnjpCvptZ8Eqjq3rwAdCjsiEYxMcqTee91lMUOGvAU27uoXhyhkI7MXbxrdopPOfYyKNv6ZAsc63J8ihVJrV763frNAyphT0OsFiesCEf/xAqK7XmN/W+OVRiqzoa6stFbFiOuJweYjzApae9FLyg8oAJ2+nSuepBcxMAxbstKagYHu6gkPdC7cGI70nmFVZQLYKwRSv4H20L+hltNCzT3o9xMxjYux4ZjmFGUYd9Ha65i2j+YYm19tG3/i1zPw9vm5dXvfHRK92tjwW+OP1iiilVAzCLRBDNNSYADcWbjCitkbI8Wb+XJ8Ou9dS7O1L/hZ7AvBnlGZnxz7nVwwFd1t3DcfElCN7dr5fwj/hMKGfHDQON+S4VQreI/st8+oubxli4fEb2zGnOoayuuIror7P6Wef5tnCBqaX1094tVKEKHCZRmRaIKZ9x8/Y/RGp6/JdrgwastAbA9beiWxx+8Fdpsyxt4aWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEVBaXJINHlvczVMZmtqZWJzeDZMZEZjUnEyWi9aRFZXeDBtRHRHaEdhbDd6?=
 =?utf-8?B?NU5QdmxqaEtGWWpJYloxYU5ONUttaU1oOWJ4QWM5aU1FYXdYNlAvbEgxcE9w?=
 =?utf-8?B?WnYvUVdaaXBuZjNrT2liR0lOaWFVS2NiOWJGQ29WUmNBL04zRzlzVm9RRk5C?=
 =?utf-8?B?REZrVWsvUkU5aGgxaXorL1JzQmZ4QXBUZTRRV0VIRno0TVlwRm1IUlkyZ1BG?=
 =?utf-8?B?VjlwVjZZb3RTZW5SUjhROTlHd25lN3c5Z2cvT3hReDJtek9yVW9Rd1lDSUZ1?=
 =?utf-8?B?Vm1qU0ViblYwVXJiNk9tK0VXcVhXNEFJbmtONndaallOTGUyMEJCSTIvYVhF?=
 =?utf-8?B?dEQ0SmlwNjV5emtKVEI2cWQ2aXNNalMvd2dHWk9IMGhsMDJnbUd3Z3hVcDgw?=
 =?utf-8?B?cHMrazNpNG5tbHBYbTg5TXpwQWNNd1ZzTCt4Mi84LzI4QnJRM3hDYkpqZWhF?=
 =?utf-8?B?eVRWVGlIM2JERGtpdTBjUSs4VCtmdlkyY2lRVm5QV3E0WFN0N0tiTWpqS0FS?=
 =?utf-8?B?cmJiM3VOY0RMR0g4WUxsOEVKKzUwcGVDU1lHelhnN3FSZ1lVbnUrUDdvZlM3?=
 =?utf-8?B?dnorb3IzeVkzbFkyU1dZYjk2TnFabjZ3ME5kRUpCckcwb21IYlpWZXZqSmJq?=
 =?utf-8?B?a2tsdjMvbVNtOHNzR3plM3gzRHpUY3V6c29wV3R6TnFwRTB0azVWRXM4WkZq?=
 =?utf-8?B?RVNTNmlCT3RiTjIvaGV3ZzJWeWtnU0FiNTJDS0xqTDduMy8rM0w5TFVwdmJj?=
 =?utf-8?B?SUZUeXNLZmpzeGl2WnphRitqQTFPeUJrWW9JSkt1b1VTaFpkZlRreXVyMnlS?=
 =?utf-8?B?bnU4NmgydlFyQ2IzK0RVcXJLZEZDcHdmY3JRWGFQN01iek8yaGhNZVhuU09h?=
 =?utf-8?B?YkNBRFRWZUIyK2FMWlh1V1d5OXBVbmVDeHc5eTFJZlBibkRyTVIwYmVsT2hZ?=
 =?utf-8?B?dWRwUTJBekpLbFVONkNxSXpMRHdIbmVEWkNVazBIbEptN1kyUmFBSVNQQzlv?=
 =?utf-8?B?cGEwMHVWb3JaTDV0dmFyT0hJUS9rSFRXSHVkZFMyMEpuSTRPd3FRWEtlNlBv?=
 =?utf-8?B?Wk8waENybVpmZWlzQWY4UU1WTWhXTnU3N3ZLYTc4N3NyeU1aYVpseHhKSFdX?=
 =?utf-8?B?YnZ6NnJYcDNYNkVQWm1jQXhNTHA1eVZITjlOUEFnR0ZxQnI5Tk95a2EwUUpN?=
 =?utf-8?B?S25wVnhnTlAxSUJ0ZEtmc3BYMUdnS0dhQXFSYk5iaVBRbDdJeDJRN3NvQVNE?=
 =?utf-8?B?elRlb2kxSW1ITG8yZmx4QWxXcVBxWDJzWHlCbUtiQng4WDJCb1hQSjhNSnhF?=
 =?utf-8?B?K2EwRjF0SmtGUnBLdm1melMrbGNkT0ZyYUR4N3hvYjhxZHhsNnRNY08zb0Qv?=
 =?utf-8?B?NVRJMkhzaEhycWhNUUx1UUc5aVdJTGlZRVRPbWJ6MVNWZkhndGpjSGVIZlI0?=
 =?utf-8?B?aWR1N2xYc3hSR1p0ZUdzM2FEenl1dU5kZGRLNEh1SjVXTHkxR1grSlc3V3ZT?=
 =?utf-8?B?bVVVZ1FZazVLN1hZQVRYZmdkekE5UEJhc3hybStSSFhkcHZxWWlCcXB3UnRi?=
 =?utf-8?B?d0YyWTBGWHRMdU80QnZsU0xVNkZqczF4cHM1RWFNcjZCTmM1dlpyaUdxYUNF?=
 =?utf-8?B?aUtxa1dqZWlIU3RmSVcwclpNbzRLc3lnWDF6VFJRaG5XK3lQNnU5bzgwVHFS?=
 =?utf-8?B?d0M3Q2F1aEU1c05OWFJhcFlwMGVES3A3d21LT2JOMVRTWk9FWEY3OUw2R3NE?=
 =?utf-8?B?YWt5a1lTS1VkL3Y1YmNYeEZJaTVwZ2lKUitDUEk2cC9ycWNZUWxJNjg5eTEr?=
 =?utf-8?B?Ny9aK24zNGpmdUF5QlVnZzEzeTNBcWVvVllCNjFVWlVpWVF1M2hJbGtWMU1x?=
 =?utf-8?B?WjJoRUlqVmRMNUNjWThBR2MyczErMUZWeXBJZC9DR214Ri8rL3B5MWJkOXdZ?=
 =?utf-8?B?WURIbTNGbFowNEV3T2pXb2JBUnBvaC90OWVZTlBMYzhucmZtaHdBMmdSMWt4?=
 =?utf-8?B?M2VEQVpZbjNXZmwrbE5sbDRac0l1b2lHbmJDbjZHNXJqOEJQU1dNU0lrSTgr?=
 =?utf-8?B?c1lwZUt3Qlh6d241RkVpc0VRTDhJY0FSaGxRR1ZQd1F2Uy9yYlpwM0ZCRDk1?=
 =?utf-8?B?eDV4VEtaMDBLQUNXaGxBOSt3Vy9zb3dPTzJwY3pqZ3VOcTZ6N3VyZ21BUkhy?=
 =?utf-8?B?bFFjKzlDRjFiQ3VBTUd6M25pN0F0WXdRUmpiOVVFOWlhVExWREhiTjNtRkI4?=
 =?utf-8?B?Q1F2d3RRRWNUZ0ZZbzV2cEdpMDBYcEJuN09FYy9sODMwanFJVWZMSzloQVBS?=
 =?utf-8?B?dzhGcU1EZjBDYXJDQ041UFBDY3ZMTXpJVTVUWUs3OVdKOUJ0VlAwWDdBUllD?=
 =?utf-8?Q?JYpuXgh/oVbOSWSYGy7FFjNtEOi0P2CFFurFS?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033b5274-d1f2-486e-8b55-08df44b57143
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:16:59.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJpBvYf5zE4wB/ka+IuRFgR98sYt5LWo8UOBkwjYi7WVGeTJpZEWDTtMyGfqG0sy424fKW1gHUwn6YmRDePE7v0UBqvefIZyzB1ytsn7vEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9777

> Can find_lock_later_rq(p, rq) bypass the dl_task_bw_span(p) check and
> migrate p onto an isolated CPU in def_root_domain?

Yes. After the rebuild, the offline rq is in def_root_domain, so the
search only sees the isolated CPUs. The task and its bandwidth then
move there with no admission test. The planned next version drops that
result if the task still has an active CPU in its own root domain. It
then takes the fallback, which prefers that root domain.

> Does rejecting !cpu_active(cpu) here cause dl_task_bw_span() to return
> NULL while a CPU is being deactivated?

Yes. Until the rebuild, the root domain of that CPU still counts the
task. The planned next version returns its span in that window. It
returns NULL only for a housekeeping CPU that the rebuild already put
in def_root_domain. The same holds the other way: a task counted on an
isolated CPU that goes offline now stays on the isolated side.

A shorter window is left. The rebuild bumps dl_bw_gen before its walk
reaches each task. In between, dl_task_bw_span() returns NULL for that
task, and the CPU is picked without a preference. The window lasts one
walk of the task list.

> Because the new (recorded >= 0) block returns recorded whenever
> cpumask_test_cpu(recorded, msk) is true, the existing else-if branch
> right below this hunk is now unreachable:

Right. The planned next version drops the branch. It also refills the
mask before the test of the kind of CPU.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
