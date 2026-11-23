Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442311;
	b=MR0Txm9k9f0njxorMqP858y283Cxgpp5UINLOrWc4SXfbLAg/W915EVB3LoqZMcFzXjI
	 Q00NE8JBtYGPpJqFtKJ5s6yTNV1ASGqz0uuu0DPMOIvpvaib7WnhhMQzRGOZ1JtpJ26Ey
	 h4PphL3qcfio+5rS4UpeIf/1HhmPhNmD6nfmbsygUoSvELkCCXJvqB8Rq+GxY4RAiHEsD
	 kfkZXT89IVsr6Gxd0GYOOkhAtyRPPQlaJ/5WPFYF/lMCh9Hqa+cQv8cA9egn2d4b8oF6Q
	 5FrxuUSb78mjqJehVa2rOY08r3rSJhC1kkYVSSgqjyc24/tnv6cxbUe9Lm4Hg3K56yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442311;
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
	bh=3j4OL5z6IPWVvVzhvQ7GmqG6FNOqjalV0EMifvPt3JM=;
	b=SjO2gOVYCjb08oLkqe8p7ynGNvE1+Z/3YvSXyohc/P+OqIRryhxILYePxRDaxRFQGd41
	 OU/PZ2JQsU5ehxaX3EYT2C7l0zhFBz5sZtPucMBpT84vDx2C7IUrQG+IBgAEaSM9GSLT7
	 AhLwEy38AiLh6g4uHUQB09zrIVhM9NBqudORTudHoaMVji8knjqcg04WTU4CKP/HTogh8
	 Ptb5rboff0CoawCZT7kYbpvHL1CTTEONbGG6iBHr1Seie0F/iAmbZUSoWDpTD89/iZb8j
	 PpKD8r22qToO4eY23yzZkDOJ0borblIGWYcq/zfFtFwpTX21o+GJ9zvB5FVde57YBZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="Y3/HezP6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.125
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020125.outbound.protection.outlook.com [52.101.189.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2D606A32A;
	Mon, 23 Nov 2026 13:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F2D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Y3/HezP6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIiGtNQIG5jgkHg65aLDVXHD5u/2Y+5Uh2udUfkUjgeiQ1QMsRo5gOYrb2pzpHkBXYsjFmR6Er0wNoLUcqYFizWmIMcMeWr/GQvkVaa6KUCd86gfIZwIq4L/JxyEobKEikTBT8oL2Pyeb/MC7fLGa0sd6xWHC+H+LdGcHgBWBpPcx62aEhU4RNfGaEtaaZAFHki4+O3EWTutO4mBSNRVnO0883GSCnviX6gW0JDgIPbcGabfEQRjv6aYlCK9fQiflNNMMtMcMG/A5Kcp3/Qadurl+qo8lfoqZJ0tvgsQEq9BpfxkVfpzz6RiNuAmhv/JyxkNYQkDMJZXDKI1ga4g4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j4OL5z6IPWVvVzhvQ7GmqG6FNOqjalV0EMifvPt3JM=;
 b=vbr1oksxcAQEfomuCy5j+a/TateMYacfLPzjfCsKDnSj1ut28vyBHwbugMhO9+MPLhX1SN99XmVrAiq+r71aihhQTDSKam6FCzOg77zSwnj+XfFWZ4LZ3+6TpkJWUKNe/el2qBD9cojCJzE7HzaGpyjE2YkaAv6d5oHCMXO2x86TYq5+R28HG+wj6KQnOfqjC9hW/FbBkoVUm4DzyeuskAoSwM6fYt0ULRnmAzsWKYpTXmWhfpa+MJAm3mPUIts6webvqrOJwxmNQb5wSAGExE/PGLac52wQfbgHQyZoVaS8q0SiiRC++PFeO1IpI6+3QyByjBjl9liisYD+1yfc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j4OL5z6IPWVvVzhvQ7GmqG6FNOqjalV0EMifvPt3JM=;
 b=Y3/HezP6D1/ivZXyG7LFWreHlv54kMGmrJ9ooBm95rI/zUJrmoziZqIMIcnnr0Mw030gauDXRRbx/m9w7udW7S+qgPt54jmbiBtvVxl7iiwt2totSsjqvOHBxoOlVH55vvs/n4ea8PfmA0m89+mtrYmjdV1tXIGAZSEF+WOyfV9RULDBL5/nni/SEY6eXC26c6MVeOEnAuESuBtfwjJ/3Mfb6O8tF2PTfwOULSn7rrH388K7I+RI1mR+YQ9J2v5ReiZVukKWrKUuAuh1fZQr+vaT6uD7lrwJEtIePgGT/7XB5YDHY4iFMZltPS7HS92RQW4es6NnAbahM3Xmmvjy4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB201539.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:113::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:58:26 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:58:26 +0000
Message-ID: <d14a11ae-23d2-435b-8192-e5e361e2d6e2@efficios.com>
Date: Mon, 23 Nov 2026 08:58:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/40] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <4a72b203ecf2e3de65f7e0ef7fda8eb415af0014.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226169@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226169@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::25) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB201539:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cace10a-ee1c-46ae-6ebb-08df4969d8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|11062099010|22082099003|7136999003|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	mT+s0PmwZtIxFnBCyyibLq+CcQEsoBOFIX9CXwjyXZINtgV3wnpEmBcwklwZSGwajGKtu+cYeQ3tvOmS+X0fhVxHu7lxG4FfSHEeq0e0W0XKTvLPe54sCPAKe/pIrwZIquzGMJcn/LYFy3YC8uF8pSK3vUyfo/NdQUyUzU4/0e5Dq4GquSDGSIwZUPss1p4JzaBXwA5jffbXJvDTPiTCfzjPwZ4lZpWZNBpNIu9kU/PBe+yFw8i3ZqETd2KBSGvz1Bnd6AYinCEasKn3cNVPsvdKdvevsqhsXnHTP/Socps686GYtzHFVChIRh07LBXSqlHDaLhgRgv9IEfwyJTxqLmYBvUj9phcn3Q+2n0ykSSZtaagT/ea4wbmumRw3XWcBlfe0/v3Gw1fWTLq3iYEvtfiIFACz1kjmALQOt92sDhKOGBTms68EfoSvwdmos3+Zl0rsZAqLnrDqrEuFOJOvLcgAzKymltM5Mq1YP7/pGQCyysf+korxg04XpK0KQkJv7w7kYxUIdj0fWt8TzU5CO/O29nR4iu43nhY2lRz9ZJEsugaBLImcz89eVit536e6dMFUmX36YW2HN/8ok8T/QUVXHlnVjW5wdmixW0J4R4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(11062099010)(22082099003)(7136999003)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldxSkVsRnJJNXNzdlIxWUE3R1RZOXF0QW5DWEc5ZFovTmhjUEZpcnBZc2Q0?=
 =?utf-8?B?TXNxaWREdHZiMnYrTFFBTnJYdVBNTllZQlFndzlCSVRyVEFoNmFVWkp5MHJV?=
 =?utf-8?B?VlhGSzUzK0RSbFlCcWp0MTdpTlBWQ2VzaG9laW5tMUF2cTJPRjRuM1pJaU9X?=
 =?utf-8?B?aG5Fenh5MUZPc0s0UEEyemZxeURLZ0lDd1hnVFZOdE9TTG90TXlHQ3hRVEtP?=
 =?utf-8?B?ZnMzYm5Nbmx2aXBnQzFQUnB4TlFZY1BJZndaaTQzWFlMejIzMTRhN29sRmpQ?=
 =?utf-8?B?K0Z3TFhUekhsYzdmOFFGajNBM2x6aXFubmpLNUJTUTErenY5M1pza1dtZXgz?=
 =?utf-8?B?bzJMZEd5b0grYytpTk5JQk9UYmE2eTBHMi9tdTZMa2lBOWdQbkNONXZUa2lj?=
 =?utf-8?B?Z25YL1NRanc2YjZwM1RVR00zb1diOHI0K3ZLclpJY2VqT1BZeDFvV1dncjJE?=
 =?utf-8?B?bm4wRXcwZ21VaHBHT0tIY3NJOXd0aUYyV1J4WGJqSTB6ZjZHRkFsNy8vN0ZL?=
 =?utf-8?B?SW5WQmFrWEF2NHpkUFJXTGYrQVlKMmVOekwvMzJmc0dGVjVmd1pvak1iSGhG?=
 =?utf-8?B?VFBNUVVoSWxWZXN6RDRaZEFmZEd4ZWVGY1lwZFdMYndlMWRPWSt2bjB1dm94?=
 =?utf-8?B?L0N6ZUp3bTZkeEZ2ZVhpcHJFOGZmclJvTEVkcE9xRDlWSllWaThIM3UzM2tE?=
 =?utf-8?B?d0ppajdnRHl5aHZPME9icCsxVERDa3pMRXVpRXFJM0RWekNqR3VRTEFlaVZP?=
 =?utf-8?B?dlRCMUFDYXgwR3Y3bXRSOXRzYmQ5b3RCUHB6clY5SXk1aSsvYzN3elpGWklL?=
 =?utf-8?B?elAwRm9uSWszOHJPdGM3QUxjZVZabkZOMytXWmFvZXJRZWk4TWxCWUMySHFu?=
 =?utf-8?B?eHNESCtqWmtHY0tvb3JXSWtZa3BEYStOaG0wSE0vVjJzbWFUS0gvOW56eHJm?=
 =?utf-8?B?bVEvVERCNkVpNEg4ZEswTk5yR3ZFUmU5WkdaQnhWSkFrN25Ta1lneW1kYnhR?=
 =?utf-8?B?RVF0Vmg5QjdPckJqVzFsMWFHUUdtTzU3VXFNL0xMRXZVMGYwZnhsWlliWFg0?=
 =?utf-8?B?YnRKb0ZiUWdBcHI2Y0lzTlJFZXJzeTRGeEF2Sk55cjBnREJhVnlvdEFPSU84?=
 =?utf-8?B?TWpVZFg3eVJTVnlqLzlXVVZrZWJwRjUrNjAvYUFyNDhhRXIyUlBZVnJRNjU5?=
 =?utf-8?B?cVZyK3NMMmgyOHNESjBHOU9EbmEyNk9BZ3ZTUXFLYy8zRkgwNlF5N3RCWUc1?=
 =?utf-8?B?cE05Z24rQU1zdHB4N2Vlckx0bUc4OWp4UzZsUmt3U3VJSk5VVGhKTHk1OUkr?=
 =?utf-8?B?VkFTQjduTXVNSDJoNDE2R054a1NWMVJRb3ZBYi9HaGhFd25XbmVXMjF2L3BS?=
 =?utf-8?B?TXJQSFlUdEJOUFNmd3NrSmkxTVBYQy9xZXVKcHVuS3hnbmhwTkFCeTQxUlVl?=
 =?utf-8?B?VmdVeDd3UitkUDQvWGRJU1dpQ0hxZFdqcXpIMWI2TG5ZWDhxNWRDVWt3QXBN?=
 =?utf-8?B?enY2WjVTY3QveWwrVGlFZDNJeWFULzUxallUMHhmYUgwa2tGeTFMdEFZR3RJ?=
 =?utf-8?B?RFRkWTdjZXZaNS9ValVseWNnRHNJdHM3dXNPTDdRYVIrdjArL1dhNUM5aGFi?=
 =?utf-8?B?TUkxUDd0WG9ZdTRzNThLWEFvcnhoQkJKYjJWNUtZQVNwdWNEUWRvcUJPajZP?=
 =?utf-8?B?T3dqaU9MRjF2b1djd0YzRGwvOEZIekcrdG5nSm1nSnhLRmFQMUQvbXpzckNB?=
 =?utf-8?B?YnZGalBOOFN2Qk42dGkwQlF6TzN3eUtuMk0rdmlmYmNHT2QrOXpLSUJXWFlw?=
 =?utf-8?B?NytFWXhuUlVhdUhqaDZ1eHNodm1OOWpnNmNZSlMvNjFxeElvZit4VkdFQzc1?=
 =?utf-8?B?SVB0aUg5aHh1MVpDTURJdVI2cWdpUDFrSEJrTTdhV1EvNHE5eTNhYlMyTWw0?=
 =?utf-8?B?YzJEWUNkcDBWOXk3WU1LODhJSHZoSGkweFB6Uit4R0hPc3FTcGxlTEcvMnBi?=
 =?utf-8?B?RU0wd1Z2NFJ5aGF0ZUZ5Z3owZ0Q0eDJXMU9aK1ZaUk9EV2pvVzdZdlg4QytQ?=
 =?utf-8?B?RTJ6UU1YTWlRNzgvOGJ0TjRyajRKdmhHNDg0MW0yQnovZUYvZHpoWUdnWkth?=
 =?utf-8?B?OFBuT255eTN4NmVRc3h4Sno3L3hBTm51ZXMwOUw5QUFGUGVLWmZVcUY4YmFz?=
 =?utf-8?B?RFM5UXVSK3EzdGpnUVh5OFlsK2dHSHo0U3d3U0FsQVBkQUhoY25tMC8vazlY?=
 =?utf-8?B?R3FpalVOWGVNMVFwL2oya21qNVhpeDhsaTYwUnZEVHNabnRuN3FxSmNCRkhj?=
 =?utf-8?B?UDVqQnZZUFZ0ZWpZSVpuejNXU0QvZCsxZnBPWGh5a2M1b2hpTytOZG5LbUZt?=
 =?utf-8?Q?uP8SWPOEBeSGlsFA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cace10a-ee1c-46ae-6ebb-08df4969d8c0
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:58:26.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJHR/5himCNdFOYspVIX32fpvceQEUUErMPwoIbwaK4AAzgemkFjHXONIdSbudVmfVATvRkSY6Ngj0DE4U/xxaKe9BwdZcbgYPAUyd8UEus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB201539

> Should pending also be populated when root->partition_root_state is
> PRS_ISOLATED (for example via is_partition_valid(root))? 

Yes, by reading. It is a false refusal: the child stays invalid until
its next update. It refuses too much, but it never lets a task move
unadmitted. v11 will keep it for isolated roots. Extending the pending
span to them is left for later.

> Should dl_task_keeps_root_domain() ignore tasks with
> READ_ONCE(p->__state) == TASK_DEAD, the way dl_task_leaves_span() and
> dl_task_in_cpuset() do?

Yes. A dead task runs no more. v11 will accept it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
