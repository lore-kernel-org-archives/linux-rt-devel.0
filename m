Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203580;
	b=h99Yq0nGLForjJez9GLZG+faySssRBjxbbkF5m3ep+7ciV2VPtuqoYZw1XgVdu2MiKXv
	 4RkGZroi82z8TjAlDXBcTxmqzFzp5ax8+Yzx3Ud++pcjfz6AKt7CmJe3HDSINWZIIXp4j
	 Lr2HvZlFTg7EwsFm246UvDTy3fM4oYe26LgVdJPCulRjCVWXPQlclF0xdryu7NVyU2dAZ
	 5sR9CgbY8yxK79ElN+QxR3y6FWGiKVmBVdcaNJ2+Dy8whymC2Ys1ypdyMyXb0BXr5C+Tq
	 cDRTUT/Cl/kZOdiZYfqC90+Zv2JgE7pjfj3Lzlf0NFqWzFPGklbCsipVogJHzbsfdKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203580;
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
	bh=NgEH3phKMypA7K3npKPAnEFgFceLjFmkCKq70Rd4tgA=;
	b=4FOqFqlWwEFnEW53uxHhguITo2qKFI48xRdMYh7gcQARNO+519MMHTtl48jjX/TMrj0J
	 LV35m0Mlu5GZUIoPbFWqjVpU4yNqhsZ5Af3HkLmYR4+7AJwtBa1opDGy89ilHGPttsIxx
	 WXjfxwrn0/TLJhp9+tRjn/pWh5Jm7/uKjRSHorKtDF3mSyGH/U169d/s7o/rqPnCTxdFO
	 8jJRgb52b6LogBvMOLLydoOzLHXVae531W2e6MBJyfKFecSFtona9zy7470Buyp10PuMn
	 t/JEny510s4vJxPKg8mjr3ej1PIr1X4wbJ07WNJUx0g4A0FyzIVxBB5Ov0AhhT4doZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=fZ48E0Pc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.133
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020133.outbound.protection.outlook.com [52.101.189.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBC606A6CE;
	Fri, 20 Nov 2026 19:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DBC606A6CE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=fZ48E0Pc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8T/9y5zlvI2z9z8aZDPVN8HrZdcK5KI04jlQvbwPIK4lSZUHY243r12V0xQGX52Rwlth/pKVTVZQhdgso/jvQLfH4XEDWIfB7oWc/rdJPrS9LTSP90ttfTnmqqtRVodJ8Symdr1cl26qcdsJ5lpbRrBUFd6N3L393dZi7/hXj7YoRcqBNlidBPqmTM8/46u7f5f0PCMzek0Yh3i+F5/bopenIp/662tMjDWywSOGYDeNFQVYYNxm/Q1D0SWoua8DaRCVJRN3veUtRvoZ9a7zTHb3IM5V1fia98m7GQPc8w4qHa8lWK26+ldr2jZg6nyzVA02H/3Zbeg005K/L/pxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgEH3phKMypA7K3npKPAnEFgFceLjFmkCKq70Rd4tgA=;
 b=cr312P6rueTa0vAkMRCFau21cZr1TQtDOfdKVwNtWDtkt5wybYy8Nc3taaqmn+zYeIJwKUoXyC3pjkZlyqhTQiQHXcA5Ojk0AyTV0fBEajrJ3m8K7Gb4L2RGj1kzz4td/qfUzuzuQjZ0gcIrpio7L4BGlTbqLc9q3FrnnvNrFc2SvTY7HaEBGM96lXIBTY+m2Xxra2rxIbaPCl9m8fgBNbbNZMuiH+Y7wtLbm/8qPOlbKy04OztlBGrHwSLPdH2UScjG5H9fX195stu62BTq1xbF6SuZiJ+a8sNsaMGRzXQvrXuTlgdAcMbB26HC87hodJIVWwWvWIWAsbv3ArJkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgEH3phKMypA7K3npKPAnEFgFceLjFmkCKq70Rd4tgA=;
 b=fZ48E0PcUWlViYoK49vpvgRkBrsL5hh4e217CEWahVf/dCpYk0aNLjcDmAvMNvZ1rngyutFFc0JwPt8txdaduCa5uZYbgPnEtbFwukD4w3X8YHKKRma6lS4+d1j2J6D8LV2gHvgto3GgtSFe7Y5+1hz2SuNrUmv0sqth0ATzPpszYbFzbyQImBL4UDbwMC79RFgz+ZLmwWb77i/2c4oGSPYJ59CyoOWfrpfAt65JtF6a7HWSdqh6pLkky9AItZMID7411Wplx3jYicL/RYB3mA2qnEwoJ0FUgBIdKuET6q5icchh79eD3PUHHPPMUHzORsd1cf16ZCVxGFJLEN6bdw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB764689.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:202::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:39:36 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:39:36 +0000
Message-ID: <cfdd49bf-44bb-4b4c-bc70-30443cd0aeae@efficios.com>
Date: Fri, 20 Nov 2026 14:39:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 21/33] rtmutex: Continue the walk when the owner's top
 waiter changes lock
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <6438d828d974eeda3fc9bdf8a2caeb4392e96cd6.1795181240.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-225348@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-225348@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0195.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::14) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB764689:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddda8ae-9eb2-4a7d-7945-08df473e0273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|3023799007|56012099006|4143699003|261028144727099003|261026121527099003|261022105027099003|10067099003|261026140227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	B3TfeFmQMaXZ4kjiCKYUczsZiUY3isYOTQ4ZEB5XL5shvYr1P8qyoJdq3jMhaGGihjrphr0mn2q8tVAZ5/rHrELo6oamnupGo0/vWeuyQXdyM6uwE9o0JApm300Wg9nW5pJZfwRi4ygHZHdbu68i1xJ2KVCWTCPRs6nCBijL+k2J8SngtO09YgpsJ3d7qPzeNvE+64qLKSpxJVxgXUyqVej9cAca/WidCXyuKBw4I270X+oGZUUW1S9qlXy9ILbSCuCWPxoE64Jd3vog9HD2vn9IRNQ3dWsIu++17FVzVQOhqEqWQqVzDvZo91Xmxpueb5KSJ7qBwsu+PIaPFnR4Mi8hHhSrQ/rrlnu9Wc1ZZeUEzOl5Hfns3iQmK5xRIz4PZvLwsj7nF15urUVgnWUStw0P5gxKBhu+MEjYngbLRdjvP3KPbDzvFJ7Se/8dqu/qhDcqFJldCcxzGN2e9i/IlBoCgWr0r/TP32UkgMH+eRiNlMpPYQm2SPVULQgUs/F4JzfNI0P8sOJe1Fl9Z9FNKYICYtZOrdpq1V4KIX/TjwyUw2CK+/3GpZOFyzdUFH6sAF+o53EILMVTEB13ux2/Ev6UsT1FQo1ZYGm+ZbN0e3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(261028144727099003)(261026121527099003)(261022105027099003)(10067099003)(261026140227099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG5oZkROeUFPdjd6dmtQeE8xZElKcGJtell1MUpFbjAvRkF1RmQwZFFOdGNS?=
 =?utf-8?B?bGh0eGtUWDA5MTY0Q05xSGcxTXo1Nk91SmkyYllIWWdiWXJwamtNUkFMbHZB?=
 =?utf-8?B?c3FHQWI3cGJvQmhtYnlGRXFCa01lelNhc3JEZTVXOGpFcUM3WDlVRk1zMVVD?=
 =?utf-8?B?cjVEQytqQ0RUZkxMNlZMS0kzOW1NU1JXS01mUnprYUZFeDExVGtyTUNIcE9o?=
 =?utf-8?B?SjRkeEVMSkI3ZVo0ZExTdXZRSkNFemhTalVMREMyWm1haHNxNWFKcHdTYzlr?=
 =?utf-8?B?eSs3eW9zcnU0RXhQS2R5amxKZit3azBKQzFpVitZNm9wdU5PK0hNUkZTa1NY?=
 =?utf-8?B?a1NyT2xKUVV4RmJMRGxRSUdtOWlsQVAzYzBnYXhHYm1JUElnU1JUL01pR2hz?=
 =?utf-8?B?NmRCeVI0WGliVElRblVTTDlDTkg3L09ld2FucFBMalFiRzVjaTIxanNDVUdJ?=
 =?utf-8?B?aUlFNHE1aFppQkpaeW9QdXlXR0FDY0t2M1VpNDF5RXVVNElJZS8rTVZ3ZWxZ?=
 =?utf-8?B?aTBLaHZpNDZQaUlkQWJoZm9wZnpGMTFHR3JkekdWanNEenVBU3ZmdzZ2UGVv?=
 =?utf-8?B?SWUvUmFacW9ub2V1L0w0b1I3eDIrZ25oejA0M3krSzVBRi9sNm5xUjBYZDM2?=
 =?utf-8?B?SVl2MjkwajBOSnFxYWgzVmJsd0VQSXdGR3IzSm9GUjJPNytZTXBmLzA1R01H?=
 =?utf-8?B?ZTdBemtuTzgwZ3RPckF0bndZVjlFYllVNU1keXNqTVlVdXRUMjZaK3JhbEpx?=
 =?utf-8?B?NWFVTjk2VVF5UGVQS3FvT0pubHBEYzRvKy8zMFhEaGJnUHBtSkxlUEFVRWUw?=
 =?utf-8?B?MjZKS2VUSnZMMWx6Z0ttMUw2cThVOUMwTnFrcUJWMEFCVGM4azBIM1liQWxG?=
 =?utf-8?B?b2VTcGo4QUUycjkvRGZCNnhSWDU1YlVybEo4bDlCVS9FVmduTy95NnpqNTRk?=
 =?utf-8?B?Z3B6MW9NUjQ4K052WWVxZWV6OUc5RmFJOGVDMVBSYWNTWitWUC8vNm1qT3pI?=
 =?utf-8?B?THBuNXNlWldURWEwc3pjaUNWNmp5TkhtcjlSenhqMmZQNDdnbWxiaGNqQXp1?=
 =?utf-8?B?S3pGdjZ4ajdOMG5kMWJndDVLMXFnY0VpL1FybWxDeTMvc3czTU81RHRaUEVj?=
 =?utf-8?B?NXZ3L2FKaU13VVA3REl5TE43NGtHd1NxRGF4YldCRWFDMWw2ekx6Z1RobWpH?=
 =?utf-8?B?eG1LMU1ocVJ5K1Z0MnV5dHZWbFZ0dVJIakFac3BNenNVQVBUUHhLZjNCUXNH?=
 =?utf-8?B?VFR2N01XaU5rbXc5dVRyeEprbHM5ZlF4ekhlZ1JGWnZVdFFtOUFKbUsySnhF?=
 =?utf-8?B?cWcwMGErQXBZYTdsQWhSaXNDMmtQZ1p0UlVtS2k4U2MrZFh2ak91eVdVdHkr?=
 =?utf-8?B?N2hENmlGT0t3KyszR2VIVWpQUm1rNHVydkpWRGRFMzZQYitUdVJxVXJMYmsr?=
 =?utf-8?B?d1JlV0kzWnNRRU9SZWRsb2FCRkd0cUR5aEVqY3ZMbnFqRUJIMnN6NzVhQlRz?=
 =?utf-8?B?TEhDVnVvMUZzRURGY2dqTFVXOHEvaWZqbVV2eXZ6NmZNczY0VWMvU3Z6K29V?=
 =?utf-8?B?cEphblRzMGEyU3MyQXBOb3ZiNzg0dFNXSERKQjVRVVltNFdnNHRJVE9jU3FC?=
 =?utf-8?B?Q1BuRWlXT1ZIYUFsTjdsbFkwdWhVd083SldjYk5oaGR5RENMNWpLUWgyRDZG?=
 =?utf-8?B?STU1bTNCTTZIWEhtTVRXMTZvcVJxd2F0SVZxRzFZcnpaZ3lRRUYvNnFoWlV1?=
 =?utf-8?B?dzgyNUhEeGdiTStrZUV2alNsQWpwdFo2RkxWaTkvKzlZZmU5dWFaNFRQOVIx?=
 =?utf-8?B?STZQWFp1R0l1U2NFREMrd0tOMVQxNXVlb1RvazFBQTN6UGJHcFZuZk53MWk3?=
 =?utf-8?B?bVR0bkU5elhUS1gzTk1ENXdwOUZCTDR2YnhhckFLMnhnTXhISVVUV3drUnNX?=
 =?utf-8?B?UTR4QzJrU1VLNElzZ2dLSy9TamdKWk5raktoWGViREYzbkpYOVl0dUNzWjVD?=
 =?utf-8?B?Tm9aK1BLOG1ZOEJsL2htUDBhR05GYlU0MGJUUDlMNy8xUlgzeTA1NGxkTi80?=
 =?utf-8?B?WFBsL3JrN2F5UDFJMWhKb2dVYklNZjhObVhyQVlXNWZISmt0a3ZUZnlDRVdM?=
 =?utf-8?B?cWdSUTBobForV2JZYnIwMkNaSHg1WndoOHVSOHhNVUR3dUxGK3Z2V0tRcGw5?=
 =?utf-8?B?SXFCenZBVHBCeS9HOWpiUnhOSXN5MHBNNG83U3d6TG5NZVBKeDdSZm5NU2sw?=
 =?utf-8?B?WmxhcVVIeTVLd0dJeWhqeGZPTUJkUEdwM3pZVGViWEgxT3ViZUZ2M3o0eFZK?=
 =?utf-8?B?Z3NNR2RsYjU3YVpUVndpd0IzdXdkRjRzQjFCcXhCcldvS1lrUXM4S2x1VG5N?=
 =?utf-8?Q?PAUNMce7KqiycPFEXuWua3W8IaWYwv7AVGGvY?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddda8ae-9eb2-4a7d-7945-08df473e0273
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 19:39:36.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjF/FFR9dvYHfoMP07vvblHf0pXChlFWXc1cbVQA8PQDJQoYYNJcYUJkNepU5kNHE3ihq4u9OiIdYy3Q3oW9qot+P1kTBmxFIAj6FQbAtVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB764689

> Can this !task_has_pi_waiters(task) check still stop a deboost chain walk
> early and leave the next owner with a stale priority or dangling
> SCHED_DEADLINE donor?

Yes, but not in this order. When X times out first, its
remove_waiter() makes W's waiter the top pi waiter of M. So step 2
goes on.

The walk does stop if W times out first. O, M and X are SCHED_OTHER
tasks. W is a SCHED_DEADLINE task. Another task, S, changes the policy
of W:

  O         M            S                          W                          X

  locks L2  locks L1
            blocks on L2
                                                    blocks on L1
                                                      M, O get W's parameters
                                                                               blocks on L1
                         sched_setscheduler(W)
                           walk at L1: W behind X,
                             M deboosted
                                                    times out on L1
                                                      not top waiter: no walk
                                                                               times out on L1
                                                                                 M: no pi waiters
                                                                                 walk from M:
                                                                                   preempted
                           walk at M:
                             no pi waiters, stops
                                                    exits

O keeps W's parameters until X's walk reaches it.

v10 will remove this check too, as you propose. Then S's walk requeues
M's waiter on L2 and deboosts O. But a walk from a waiter that leaves
can still come late, with no help from this check. So v10 will also
hold a reference on the donor's task_struct while a boost points at
it. The new patch is "sched/deadline: Hold a reference on the deadline
donor of a boosted task".

No case will test this order. It needs a walk preempted at the right
step.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
