Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150708;
	b=qdWRmOurjB1Q3BS+T2pDv1YS+KyWeH3DCsT1s/t0Os22D/lLbjt1F7sJoYOEyTVL50My
	 dv3Fa+zINJeOhaT22GidStyXhoLUsEZENpvgSZBTUYnqxW57AiEVfi2jD2geCX29ddebm
	 f9COzllQTJ/5PDhYzfovzTRKKWrgc4k9RsqjhEi18kyCtWrzpdlQIRZqnrXQ9LRRcbdsl
	 Mvy3T7kIY/iseQTM8cLlMUTdCYApzm4f/71Tw1i7i/6p6PNcYPBSk726PumHeOLQBWr27
	 mI9ZYn6IYYe1WoPsAy66Wrsfp5d5SUXqmpK/TrNNDq/uMrmJsnLt0jHfDYP7+3Xj02w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150708;
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
	bh=S3378glPIUpb/Np4ls/UMSQim6gLRzP7jb20yzp7mKo=;
	b=g2QEu2SY/KkvZkNwSJPHTILgX4xTWYhagduAwKi0ciiaX2+t6duceKix5y3hsKEByTRx
	 xJD9aPKS4mlWGKrllV8QHNMPYy+oH1rYbRQBBAFmAMzqnmKg+lQm6mpkdXbLwXgcu4aNY
	 L+/5OzJJxR9UAVGRnLljBnuTE7mFhM8pkOUlsvobPfSdCAWta7GD5IbrZjeiwPA+UkaaQ
	 VDyuVfND75z4EtWCAG8H+WNhnXKl7t4K5Qg6Dphg0H+24/q4fzAR2pjX8qsC+JfG+1kQW
	 LTWstzrDRPr1zs3GDJtH+j+a5CvLiWo0OM9hK2MBZIlV3LOOqL9IQscXZfqNkovW3zQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=G6DZTXSm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.128
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022128.outbound.protection.outlook.com [40.107.193.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA4606A320;
	Sun,  8 Nov 2026 15:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCA4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=G6DZTXSm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR0kqlKldBmd2BYffpPGGc3hhfyrXNpPzxgCqo82skc2oH5QFaOsCIZHgBU/11XYEwRVFyQwrXiPSIfZMjw1jj/WySZifreCRd9Xc/hJUngOPC2PSwzeKWN0Ag6jJMepxiG4F1M/wPJZkyRbef8VGjqkjAVZ/36fMp+n60MUW3WORd7afmg/0Z9Bavhcng/qtfLM8EsQPrsZMR09tbSukx0UjXlscPfqh4MCZ04VFfWgMmn+60c6gu/xIha53wq95EPC0CHKW3tYIrNJtZxuLDGsNzizup8onQsR0+BEXvaNRSL2kr44+dywqsWbdImAgaX51ZBamjMXO5Vn+7QZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3378glPIUpb/Np4ls/UMSQim6gLRzP7jb20yzp7mKo=;
 b=fZxXy1+fg4mBi29YjWVdyHgoomtQDWuBkD29/X31PwURGhCVkQEGkmJK/63s5yN+Fi0sx7GKJSQ5EnMT3OfvhC6eJHlXqrNdXAGPnV9b2sL/9R7xcPFhGnT3IHp2J1zgGEr7uKMzY+H0ya7aYnuf9EDPDYay+UpXbiMbZm/TJf82i6Ez/dlBp0/gtnyHh9uBg1jlyb+unYXkMpASXgSUSkICAtP7wTnhMfpuPvR0eI2c3j4FxNAj7jHlqdU+bHab/vggXg5KstkRSfhzoud4AONWH/0Ic95GjJlOsUnbAGAxbdJGN192+NmnO/SXWDyQSx/uNs4bt8MKCpS25r8xug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3378glPIUpb/Np4ls/UMSQim6gLRzP7jb20yzp7mKo=;
 b=G6DZTXSmIYunFME7kUYCYEconqHkBU8tarsuzBzWahdglorhP/ECGurY11qytvaFM/Sib/yvmPHhXmIe9XUTE1FEB4+lhTp++HonIWzKewM1tBShGV5uah4PeYFDEJWXoIcItemmF7NDO5GHXgkupGNZ2QeqFXhiqkwluxLW7OrWDMAGJ4NSkLOptwiTFf0eUBZTgwy4QgqJ/C7oZ3ASDYyfYj0FFWdmy2OoitAZmIk29Gj5IDmgIr4QkQ7DRZw2GMj/VYT0FEaknTvOnNOP+YZ4iy8O7V9QpRimVBJwZxdVxfZDQ+eczsP6f3Y3FVe1BnAqGNX+/RtSPR2Pb4NWOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB373984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:11:46 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:11:46 +0000
Message-ID: <0f916c89-c184-429f-93a1-0f5b28e516b8@efficios.com>
Date: Sun, 8 Nov 2026 10:11:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/26] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-27-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202508@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-202508@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::21) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB373984:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a8e97a-3308-4189-3065-08df3daa9ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|261022105027099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	63e1zoUl8lmlmXdHXkcRLpeBb99Aat1oVJvUysmPQSOC587Rw4Xgr4Qu+dsV9L9xVDlPCSdiQxnuGvF3wgq1RVX+6Upovd3TlRLTxLr6Ony9HFHXoWbVYwr79WbUxDn9cPKcTFqP+88CzsCd4qsk1enq9XgR7bJkQOzfU+5UC7o4h64nYqPSSPNrFH4cd/P4i/RvIAC5oJz4bHEfteLYEMz412VyaV8/ZCUQFt3uVpmyWwNpICYaekj/cUUmOOCS2p9mSL0doaGkdal1l9Ex3EcLz3+ZTcYqVDRVSzjsSUEw829vsTesYQYmSi81FGjDryLlqpjSBRGp5WT20owG7dvqNsA4NSkDTkqK2uGBzviIf57dyh1VCeUK0caGj0YNJAv2gLN6+XzqTweB66X/Z6xQMNDUZDplgfhZmBRlt1fFrq6+xcHu89+OBLpYLp1gNeJsdhTisAOpYFzU0JqvzzpLZVFQ5ZrnA4JVlEvnoBgNpaA0Pj6eP6dSje66Zq9AxjOSj6E3SdjDhPSZv8LR+V6tgSxfFFXJemBIKXzD1ABYa7HU7xZZLDv9LF++PrDj3HHbQ2oJ+ykaS8Oe+ym+aZFip66Wn4Nxh8Z7rOVob/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUpTVzFPYUFWekVrOHFlYkd0UHZhbmFsL3NHajd3TGxOTnZ3UU9DYnVhVzNF?=
 =?utf-8?B?eUt2REI5RTZsNW9HbFZEeTBZRzJpWVpHL2xyVDdoaTNzeSs2alZ6WVBsTlpR?=
 =?utf-8?B?Wmk2NUg4cTQrMXJYVHM1SWZtVVFvZkxaRlZuSldJQnFDYm1mc3EzbkFlUkhV?=
 =?utf-8?B?UDVqS2M2a3ZMdmtWTU9hcWhuNWd3T3I0dTRJN2VoQTQwV2JmelRmTDFxNEdR?=
 =?utf-8?B?ZzVENnJEWWZmUkxtMnR6WVoxRk5SRUFxMDU2ZGlIeTYvdncyc2JQSlhYZVpx?=
 =?utf-8?B?STNBYTdKT21UWlhJeXBNN083eEdzQTBZOXdGQnhjUTQxVXY4RHV0bW1vdm44?=
 =?utf-8?B?M0NhdnJWeElacDJhbk9EY29PMTFMd3dVVlMxY2hqUnAyaGh0MlpUa0R0c3p6?=
 =?utf-8?B?WDhyUnZBek83WWdldGpESHR5aGZWVWcxampxMGFIMEJtY0F3bGpqMlJZSHBl?=
 =?utf-8?B?US9aUlo0WGQ5K1pDUSt1c3Z4Yzh3QUU4MnlMTC9ORWFyNFl2azBITm5wVXFv?=
 =?utf-8?B?dHlWeU9ESFNvZ1Z0QnE4WWlVTWpaSFJ4SlBzSXN4ZXJKVUhyYkdNMVdhSmhO?=
 =?utf-8?B?M0xpOWF4aGNYNHJHOTIwT1QyV05GQnJnNGpjbnB0N2tBY1U3a3pPYnZsZnRZ?=
 =?utf-8?B?UkVlWnBqRUhXbTcwU3RWRE9uVGl2ZnRRczgwTDZFQXYxa3ExQ09hTU9URldU?=
 =?utf-8?B?cjY5ajYrVFRPUGgyMFlld3hoREhuYU5sYU1Ud2thMHBXRUJsQnFqeWJiSlp6?=
 =?utf-8?B?Y1BpWVovenJwbVh5MjNoM1ZOamRXMkorVlFTaVdNc2NNMWhIZ3RzQ0cyU1VH?=
 =?utf-8?B?TzBVRno3Vm4xeFNDTVV4YlFCbzJtMTR0QXFuSE1tWnZ0K0d1UFh5MW9hUEhL?=
 =?utf-8?B?SFI4Yzh3a01sY0M1UFc1ZWFISWpKblFlRlBsdUNhNXNSRWU5dS9rL0F1QUlS?=
 =?utf-8?B?L21nM0x4M29ZcUw0VE9KTThTVVYyMTRNZGFDK3ZQY2pyMEo0dFU4SkVXUy8z?=
 =?utf-8?B?U1UvOUtyUktQVGM4cUNMbE9LRVdBOFFNeWFGdDZJOWpXWFNyYllVZFRIdmdo?=
 =?utf-8?B?a1A0ejdEcVVIRXZ4MlNsM0d6b0xyZ0sxNlA0Y0kxeEZQcmhvT1g4MGhnM2h3?=
 =?utf-8?B?R0Rhd0NqZWhGSUREWXdrZVFid0ZUMWd4VHRKNXl5MzhwdHF2elBDVUN5Nm4v?=
 =?utf-8?B?K2ZjMGtIb1dLbnhra3c0eDRTeWNBVUJjZWJna2JBNzdyLzFzZFd3SHhHbU5a?=
 =?utf-8?B?bmgwTjduWlVXSHRqdEpMaHFOaFpwRWVyTEFFa1hPKzZBZGtpRzNEeDVCb3Vu?=
 =?utf-8?B?N2Q2VWVNcHZtaGRmTjVIVjBZSTQ4REpjeWQyYkpRU3FKWDF0LzNyc0JvTnVm?=
 =?utf-8?B?TzBFTy8zWVlMeFozbHF2ZXB2SEE2MC9TbmVzZVJvcUQvQzBNOURWOVNWdnE3?=
 =?utf-8?B?Mk1FV1I5dzRnb0ZqZVpnU0d4WmMrR0plTUpJellJaTM2MG1GaXpQQlN6SmlY?=
 =?utf-8?B?QUQrSjY0TWE4Z1h0WFdMV3I3TlVLcHhpNGNONFVVbWRKam1LUEdOZnFBUWVS?=
 =?utf-8?B?eUNGWmc5aXY4NExKM1dGUTA0NW1wYXUwelhweE53c04vZVlrS1loK0lTVXlC?=
 =?utf-8?B?YzFNWXRVR2tNSDVmOEdWeTZ1UlR1K1V0VU9aZ0kxNWdzNU5JR0Q4NXZ2a3Iy?=
 =?utf-8?B?TW1YdDBZWHN6SGJ5MUpyV2JYZlRJNkJQZUlDbmNML1hRMzNkL1ltdkJDTE84?=
 =?utf-8?B?NndwdDZrdTh2OW13Z1k5U3h2N1VIeEh1SWFYbklqL2dkTlFPMDQ1MURwSFI3?=
 =?utf-8?B?bnFiZGZpNTFuWE1kRExRbVVVbkVHS25iZUxXZ3Y4UlNML2hMVXVUcWRkRkhR?=
 =?utf-8?B?dEM2aEV2QmRPUDNING5uWFgzSVFud2Y4OGxJTFNDS1U3UTBZMHFNelBKUGNE?=
 =?utf-8?B?WTdoTXc3RjJrdWV6Y3BuZzNaMXFSTkgxam1kOXhHQVByQnNBMWNYR2lvbWQ1?=
 =?utf-8?B?cWNiK1VQTVJWWjVSSGpFUDJraThxWHg3OUgwcHVhVDl4R0NhSXlqM1BvM3B6?=
 =?utf-8?B?ZFJpV29SYVNxNk9SdmdiZlFFcC8wUHlNeW5pVXpsQStJc0VBTXRpWnMxY0VY?=
 =?utf-8?B?NERkQzJSdklsMldYMmJSZXN1UTdrQ2taT09RMk1WRnQ5VWQvd0I0WnA3eUhE?=
 =?utf-8?B?c012Vm1DdVFwd0xMOEtJNTkzNGppcFdTVXUxN29wRldPZisvcnlieXRkTWtG?=
 =?utf-8?B?Z2dKNFYrcTlWYTlNanJrU0YvRTFJdkg5Y2JoMDBKRjhhL2lrck1xd0djSE8y?=
 =?utf-8?B?QUs3SzhKVlB1RjN1aDFTN2RKamlrWmJXajVGelBMUlJkeGRCdG1NcWJ2d0hJ?=
 =?utf-8?Q?buSeLvRMDDpvHME4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a8e97a-3308-4189-3065-08df3daa9ac9
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:11:46.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTgpnFO+kFmcej6PzblYZwEb0hQEAjn8XhAM6bJ8p+mMGg37+Jgm8Hr93hOmzM0pufKE34FtPfrejTNMWa1hjCcEHH9hg5si4Hj9kp9yqw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB373984

On 2026-11-06 21:25, sashiko-bot@kernel.org wrote:
 > unchecked boosting_waiter() return and boost state

Right. In v5 both cases wait until the owner runs at the waiter's
priority, and fail if the waiter's wait did not time out.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
