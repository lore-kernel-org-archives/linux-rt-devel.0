Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795036247;
	b=Fa6bMaY3vIOnktL6dUFEtsCRoiJVY+Ayk8m/pLS8LG3ciiesHV/JfGGrnz41zFyxu9V1
	 3IGPa2zp5J2A/8g79PHp7AtUOy2HWPVMMiyHNdB7rV/+YjILVuNya0jz/sJkgcaAt2INj
	 DRGJsm88wAPEJNQPjTME0fRJWmHdyYot8UUC+bcz1siEe6y+N81A+ped48UEQ/BvzFOlL
	 nKR0urfSJ4C+vVLk1NHwxOP52jL7j743oxLxztX3BRTVadHCo+1B56Wr2+DeKTvYKBK82
	 XR3okJLj8Eic0lhipbi28ubTjdlrf2Xu1X4Nku2EOyO9flEjbwNLLR8NOWaXSb4Mf9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036247;
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
	bh=JgtH1NpupymNE6ZK7Y5iOpN8QT98//Bp9OyNqIqQm0c=;
	b=MAzDet+Az2pth7Bky8tf307GgoBiAHp6QYFMqco5PubzNB8Br3YhZOL73wG3WGZCqo08
	 rXU5tfy9BdX1CJcKSj9P2eQJxkBnhQl9ORWvc3EYbn0dXYDBYymeIV1ZceXLa+P2usDOm
	 CdaLqPf1l3G1mkJg64HGKvOvDrmjoFHs/Um5cSW/y1JYvzXYZADPpDi0crjNTfE73Y6Lu
	 +AQAyjsS5PlxPRH9Buu/YlerBrDR2Kj1LAzel++iaty7VAVBvDSFNUnywUHGxtZ33F3VP
	 syGWm6y6Xiimjmhl/nqV5uu52LVgRif+vjhQ+M/FyWU+kMx6FYWDPUS5yDrLaGUXHCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jI0aEuW9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.72
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022072.outbound.protection.outlook.com [40.107.193.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17A606A32A;
	Wed, 18 Nov 2026 21:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A17A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=jI0aEuW9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qydpob0N6uLQQINaaiAeqIBA2zM3jNzWVNEXUeubit1aQqIoN0MpSXbrnEJUwesh3uXVwZWjUioVog6ry2fs08eEXgYiUUGf9NWB+YRGV+CMLft657wBb9kGxppKLUWZqb95N98PKlj7le8coFN8WJbqJyvuv2XySqWcQgkK8FS+sN8RTLpxJjgAKT5E7uJF8vGd1rula9uYayzXKkwtOhVgCTcX2IWIy1BHHD/sSBwD3i0ynkNdynMG1Bc3gtCKQtUI+IYs7Rihs1RA0CQ7FCU1Ekk34IEecP+VbBifL/HsbiLO+LFuGFNKBPnmhQhTGMNMn9PPtLyWnvZL8tPjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgtH1NpupymNE6ZK7Y5iOpN8QT98//Bp9OyNqIqQm0c=;
 b=E0rjX6WjxOTvJEvM5TDgXqGeisuu+vy7W5ddg6Wf7efYZxpsF5O9eUwAoFRAqXGrXiKisno6BaQGvDnanVZy90oHlWhWmNNC0+v473M5n312rI2k3eu/jBBhvcoGNWdHD8f35anXSUf6i+3atm22xKp0xf8ZjRH6Nh7rZKM/dZeX7wl20+4ck+ILPq6nC+x8AijQ1YmynN04/UxMLBtYGDrzCsY7waKENqF4MnOS/C3V4CukQVbEPY+OquGfgIMJTFzIAYyMD+N/iZTnD0awdLGu7z4nPH4qUPbc2XZYvVazW+lTWHUVmWzGFVN+uLyqZ8wSrk//VF7y96UB2xhUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgtH1NpupymNE6ZK7Y5iOpN8QT98//Bp9OyNqIqQm0c=;
 b=jI0aEuW92mzmJERNTUtrmRNHL4cRpD/jfnWGg4xyzr9b+UGxbI/1OH/gq1+oJi/lfpfw5U12Qy7HD0zTAAbd3tSZIj0KQE7zH+tDKesbTM9SZWiubxSiRCedHuE2ppaS9kG/2DD5bUVGfuXUt98vBcgg9lBXfkPc92YNQQNuhkYLKhZa11i6pGhKbDEWyL9+kzzZkphRil7mpe1OzeKTtDbDQieApDNrPY5XLWqciM+IWhMJelJA5B/LIA3Vsv0f2x+7tp+7cnNICQ19bN9LL/eSV4+iO3mP9ZlDyZIFSLI7TP9So6hLri6vaifu3XFsr5Ry44vjRCJOOuNMO0q6GA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT3PR01MB9803.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:8c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:10:45 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 21:10:45 +0000
Message-ID: <877b1999-a01b-4bfd-8986-c41b059ea1b3@efficios.com>
Date: Wed, 18 Nov 2026 16:10:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] sched/deadline: Reset the deadline and the runtime
 with the parameters
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795031605.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-221940@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-221940@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0169.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT3PR01MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cffeeb-0d25-4810-62c7-08df45b86995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|3023799007|4143699003|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	i+rn8i0m8k2j2A2CmutfXnXvLmXQeST5QyYBQS9azqYLyvMCJ5ukG96uf4IA9bSkpOP6ti1ewVnRBdxRSjL6cOE9C4tbu7ZsiatkMKlxptVVzrlMNbMGO1d10PxKh+VhXmNPnX68L9a9vhgUA9Z5FHl0tkF9zVCF3W9Qeh12utrqBSJCSVNoFb8J+tyB0LmkIxwmYaXwHJYtqQpH3vgLInSeqM6pDTiQD48eQbhGGJULH0buK4ld8T+Sx4RSiKB3SHS4mFZyeGARYZAzN9vkDB6WuwgbcyB4RCzCcWgkgPhSXGSZ/FZTq6CEVu0B37Q7V7yu+s12KsnMCwRMWhLn3wzfzIH8lQ9KSjO3J8KeDZtkSom/x0XgfcWdabcyngXmzdMKyHHNLls/8amXGvTGmPDYGDb6cVnZ5bvwg8ZzOLYRdSrQ0YIX2RjD089qMG4/6K15NCS0ov4L6ruL2PPilyEzfcqIZNFKaY1DL8EY3LyUvgFbpVw8DSSdt29ZWOZx09zg00Pi+eRnt1shRiDhQ3zgIDxUwfwHWUq0SaoUiPHXw+VWSidT1aWnVF9LP+Ck8zGVsNVXmuXFfXGvtp6p3Ffzd1Al5jLfNQWcT4qgeHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjVJeUpTTGlxcy8xV1hBS2o2S1ZrR2tLYUhNZkxmenJzUWJMc2I2dmtidEdt?=
 =?utf-8?B?YTZLVXpJS25pQ1BINVhsTDFTUE1zYmJteXZoM1IwMm5kYy9FQ1FPclpNK09V?=
 =?utf-8?B?RnVMQ1ZySXdjQjIrdXBWZngxYjQ3L1Z0RjRvRVNyaUpmV1FuRU9HSlVaYjZW?=
 =?utf-8?B?cmRRSXp5ekNBc28rbWlUSkluSXo4dTk2S0tHVGlwb2ROK3IzTUxwOXpNdmg5?=
 =?utf-8?B?S2UwUXIwV216dzNBYkMxaGtDOWVpaXNiTkFMdUcxRWpPY3ZtZUhPSkdNdjcr?=
 =?utf-8?B?Nys0YmRNOUNjcVZId0VEVzR0Q3RkVVNGUnhjam5JZ2g2Mm9jeGlyaWNUcUtY?=
 =?utf-8?B?cngycnM4aW9mMHZMZG5sdDlYeEFEQ3BrekZNZVZ2OE13SW0yQkVtaW5uTWlH?=
 =?utf-8?B?dVI0Slpod2RNM0IraFd2N0hBYkNRZFF2V29oZ0xnYVBPUXNTZ3hGR3pCRkky?=
 =?utf-8?B?aGN5T0NSWVFmNk9tMnRWbmdjbExodURTWGdibEVCbXc3RDhyaFlSUksvNzhs?=
 =?utf-8?B?SWVWOU9WS1NCdlhjd3ZzbzEwQ1NTUXhyOFdhQktqQVlzL29IYURlOUxjd3RJ?=
 =?utf-8?B?YXBRZ2FKVEthaVE1N2lxeDQ4VWw5RU5ndnU3Y3RBRExBampKbDFSY0pyTm1v?=
 =?utf-8?B?TGI2dElXNWxMemwvWjh4aGthSEJXc1RlZ05rcFZPaGJnRDVxZmNGQU5Maktp?=
 =?utf-8?B?RXN5WVBCeEgvMXJVMmtiUGU3WEIzMDdlM2prY1dUN2JNOUZlVXJaTWpEeVVx?=
 =?utf-8?B?eE9SOHE2bjFtdkxWdW5HemlMRmZFMUU3UXRDKzlSUzFRK3ZRWjhGSk53N0J4?=
 =?utf-8?B?V1pYekg5bmQ4bEVSQmRnQ3VDNERzWTJ1UDNxQ01IMThXUVFwb2JvZVk5b1JF?=
 =?utf-8?B?VmpVZVJONmdOOTRGVzNzbm1xMWNTbnlROWozbE90WCtzcDJENEJCWmdZU1NJ?=
 =?utf-8?B?ejF0c2xZN2VybzJ3TUxjeDRjMnhLYnhDRnRDaFBQN3ZNRHJZM1ZEWkNSQkFs?=
 =?utf-8?B?UjNZZ3NjZ2VxZXRlWHpVeUNZcXRETmIxVXBGSS9sd2ZLZkVMUXN2aFJWaHNu?=
 =?utf-8?B?TWpINjNJVmZiaVJRVnJDbkY4Rkp2bmh2cXdkajhjYmhUTWEyK0ZhOUxyaFFk?=
 =?utf-8?B?eTRoYlBYODdKY1NITUErQWNubGtmYUM3VkcxYkszRkd4ZHk2UkFuUTMwRTdV?=
 =?utf-8?B?Y21HbWpzejJ1M0hZS29HWDZxRno2SzdDckZEWGxiN0xNQnlXenIxNFgvZC9H?=
 =?utf-8?B?ZkZzWUJPTVh1N3dlcFpxVlo2Y1UxeGphU3QrSUhhZVp6OC9MMEVyWXUwUmpM?=
 =?utf-8?B?SkRGckVuakVLZEhiUk9WdU1JUjFzSWhBYTM4L0lRM0h1Wm9OVUNuemxqZ3Zk?=
 =?utf-8?B?Q1VQUjRsZVVIQ1UxdEd6TmdGVUVwai9yQ3NaOGs3cGxtdERpWDkrRWo5Z3NV?=
 =?utf-8?B?aS9ONnVQOXlBRC9MdlhGbkhiQ0oxdG0rRWdrL2NRejM1aGZqQlZsdXV5SmRJ?=
 =?utf-8?B?QWVzWi84VGU3bDJnMnlEMEk2bEhrUzY0ZldLbm51OXc2Q3dwZHZxUHZOTytX?=
 =?utf-8?B?Z3FkTTlERkFSY0Q1aU0yS1NBOXJvcG1WUzJzUUFNR2NaOS9NcjlHeHhxbjN4?=
 =?utf-8?B?bHQyM000UEFjbnk3Z0Q0cERVZVRWOFBvTUVFSy91d0p0dkhxd1NtY2pSMHIy?=
 =?utf-8?B?ejRtdTRUS1ppRVdpS3ZSb21rNWhYejBkamp1SGxjb2NtR2VQWUZpRFE4Q0Vh?=
 =?utf-8?B?VzV1VjhmWGxrazdTVDFERksxb0ZqNm5qWkFIN0NaWEw4dklBTWhvUEZDeVJX?=
 =?utf-8?B?SWRtNnFqT3VhL1FGNGkzSjFiS3RvSHdkT1RETTNWWGJ2NmJKTWRDQ0d6c0hI?=
 =?utf-8?B?OE45N1BzcXhVbXh4T0g1Z0M5SThjWFRvOHZNQU9ISWxpaSsxMndoTHdZNjU3?=
 =?utf-8?B?cDVubHdqa0ZOTzFPdHJhQ0JSeGVhcTlvYlVITW8vTDE5U29QWXBST1Nta1B3?=
 =?utf-8?B?WGNTNmo3UzZka2VDKzk1a0hQYkM3bFVjV08xU2Y5Y0cwQUZLWDJ1YVpzQVJJ?=
 =?utf-8?B?UnRFejFlRDN0WHQzeno0NllJeEFLTDBWTWxTZEg4NWRkWmVoYnlQQTQ5QzA1?=
 =?utf-8?B?TE5Rbk5xNzF3M3YzTjdnUkU3a0swV1pZTlY0NGo5MHU0MUZqc3hId1hNRGNn?=
 =?utf-8?B?aE1IUkFPbUllQy8zTzViM1lPcHhCSC9TdmJvWlVtK2lZUVE0T1pSL1hJMUVJ?=
 =?utf-8?B?Q05YbGNBWGZBV3lBck1ubm5seVhuRlFwNWVPQU5aenBTVjNuZFFZZGFhbUpR?=
 =?utf-8?B?SG1YSUQ0eUZMUEdXclp6bEVoWlFYc1liYS9remxlb3p0TXB5TzhTOXlHZ1BI?=
 =?utf-8?Q?sDWGWuoi13LJTGvEoWqnmrR8AfvVe7+gHd26A?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cffeeb-0d25-4810-62c7-08df45b86995
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 21:10:45.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cch0dw5BWI3gxWsmkSAdzhMHSh9k5afmuLqGft60NWb/nY09Irvr+qsFrOG+GNP2ixScYP2WfsxhSGwwRUscXVC3ez3GqL8xEiAmxAXKBag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9803

> Can a task still retain the donor's runtime and deadline after a PI
> deboost if p->dl.dl_runtime is non-zero?

Yes, in both cases. This patch only resets a task with no parameters
of its own. The second series, which applies on top of this one,
handles the others:
- "sched/deadline: Reset the donor's runtime at a deboost in the class"
  covers a task that sched_setattr() makes SCHED_DEADLINE while
  boosted. Its message names that case. 
- "sched/deadline: Count the bandwidth a boosted task is given" adds the
  new bandwidth to this_bw in __setparam_dl(). The warning goes away.
- For a task boosted before its 0-lag time, I answered on v7: the 0-lag
  time computed from the donor's deadline is upstream behaviour. "Check
  the runtime of a task that comes back runnable" checks the runtime
  when the task comes back.

> If dl_se->dl_timer was armed before the task left SCHED_DEADLINE, can
> leaving it queued in __dl_clear_params() unthrottle the task's new period
> early?

Yes. "sched/deadline: Cancel the replenishment timer with the
parameters", in the second series, cancels it in __dl_clear_params().

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
