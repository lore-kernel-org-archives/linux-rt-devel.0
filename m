Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794150675;
	b=iZM8AeVz/CrTjXv2lkBG7Y+FVG088ogus0qcTg9G+UjtllcV8uP/M0F7XRidXYJTRVHG
	 eAfCocWyc5dIIHInlrM6wgGQ4gXOYaVdz/y23u5Om3uI3L/nBmo3mRDHakSg6VKlJNBZu
	 j4MQORbB90hUYc6HtD4SgLcOPVuSjPmxs50coRvisdBHdaUflgJ3B5yZMZvIe9j8s+H0M
	 sJX+DuNDyWVcd2MjbTINa3FJw/ZJicv3VrwwpsaJ2UBBwKldMEMmg7DkG5KSPuzodBhw0
	 KtwRTqKGsiZaPWfdEVJoA2UOu/V3DL2zTCIFZnXkow5VgmJbtmiS1iq7rWFIL5GD7kA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150675;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=dV0+nMccyWQarc/69+RlgOpFFjLXGm9DFJg4qh1dscE=;
	b=nsGgwWuVBzl/pSA3EQGpxZeThYQ2xbJXq2RKagJdz5JJJtd+EHLeN0itIxqnYJJ+kD5g
	 tDiuArqPgfqIolZG8ASz3pwTFut+cV6VpxzoLEsSUdVNWi8VI5/L0yGkWK1N9e6A/sorC
	 8qzgd31L0mLauOpB+sowzCeV8SewDw/aAeQsOBpizLzGkTW3I6UFsP3Apra3ePU0YeCBs
	 nhmdgG5lBQUYjkLnV5wML5TgHBCl+PYOGGJHO6AvX0n1s6X31ubLfe2E2inna60Bb+hE/
	 hlsOPOnB3xkSqnPExXFpHnfOM3QwaJmZpULWp9spNaLnQbf1K2zXl1iNUPd/EPPA1OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=b0LjkS7W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.125
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020125.outbound.protection.outlook.com [52.101.191.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52226606A322;
	Sun,  8 Nov 2026 15:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52226606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=b0LjkS7W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1tCXxvPQ1GIgiYxTghfmq1+K5rxikfHiIHKQKlzCbXezT/mVgqQ2WlB2FBivfPqQyBM3nG7JPDdtHn9dob0TH7qHJvRLD/kqc0965SBBeaQ0KpM4Ki6/Vp6cI+4eN3QcUzKqQZMEqsqoVflysBRuvbTpIB/dbSsgxr47HenXHJd4HcWHZEwomOSm9TN+1u/NJI7h+kzaQcAz9drIXKPvHhR8ovh4kgZfZjmEloTUr760hrkRV6oWalLm9zq5Se/0audV9jH8yceV74PDyvoDbPBlIoQdVZRjkaki+r1bQhbyQhObWBDfMLrfY9+/MZoC8fR4n3OfOPcSQMlh3PlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV0+nMccyWQarc/69+RlgOpFFjLXGm9DFJg4qh1dscE=;
 b=pNPn1kTju8G4IvoRYhjcGuV1s/lWUgc9gl2GU65mCwavYleOPRaaaEzYNsTVfDcoEHRwd8oZ1cRElrQpNrre2eEHJzsZMPXz+49eAV/vp+7r2qlTb99Nrq4pjgdypb6ZuLLunmXC20JVBEH0wdiOjhyrncYdhz5ZQZGUIoEDjTXUS6aaG4ErjVQdasosyGMfS/JMLYhCoK2miIeael53G4h6SQP5DKRhX9jCpv1tCaoPaOQBeo67Ik0pnwxGlmiYxPq3HQAr5JyurB38VQ7gJE/qtom7gBj+2JYfTUGeSkpyVRb/08dRp9l5CREoseKhwsw7ABwZ7/X8F6oKt9pjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV0+nMccyWQarc/69+RlgOpFFjLXGm9DFJg4qh1dscE=;
 b=b0LjkS7WLto53ev6JMji3HuakPYNDLSFO3TOTRWNdTEuiFDRSHL9ChZVMvvsmRP1ACzBvFjO5tW77vfdoDtTkFNSibRp8ZL5f8pap03g37bQQkWQq60EuAu8GdGIqo3YE/HpEzQyIGljemiN7rYOzc1t2RHgSpnCZMlQ1lNwOsxeNAFgM0FJlgjdi3WObMyFIYhUCr6Zm6hPhlXcoVloZJBZbWoZ0gH10jo4IgPkea4+KxYctoCkQbuXHtY8Bg1U2JuFoZkDCSXkD9spqkYW18k/LGvZRdDZwMPs9nMxJyYhdy34QyL3ieGspq67UUobqoN8Xg3VSZMjN9pFGobbPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB373984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:11:14 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:11:13 +0000
Message-ID: <ad50c5d1-45fe-43d6-998a-714b520a0d2b@efficios.com>
Date: Sun, 8 Nov 2026 10:11:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/26] sched/deadline: Credit a rebuild to the CPU
 recorded with the task's bandwidth
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-21-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-202515@kernel.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <sashiko-outbox-202515@kernel.org>
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
X-MS-Office365-Filtering-Correlation-Id: 01430a13-3f6f-4055-2e5e-08df3daa8792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|261022105027099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5IKbBK4oJWZYCmivoI1fOdXuCzLmxVi0GgOy5y/iMYFgfOetIGH6i3Za6vDCoRe+DwsCPp2LaOjtPQ/TATJiCy/XfTYCd/ucqWbRW3YqJltul9m9y2/7p+OineHNAhex1rGgcc6kNzjSbqE1g3pyxyyDyd4Ipae/HmooVbYafCFpG6U4dlsp/lb/26ZdVI6E3NjChfgcD5hSfptRidzydnnUN6DONH7CLe96bv6XMIkeP6fS2PuTBOjGjto1dR1/N99SKzSnkFKUkxUn3UrfVa+HG713fRa5QtK5qGYx5yAFCM7Uf0KEGbchV3cGNdcx4LRM1ZKhbcoifuC6XbXFi3Pz9ngyw1oRnttWcJ4+yGkgwRYF+NeOEQVeqNPfSgZH00EEIUzYD6t+c6xfzRlTwQzQ8QnL4pDcW6uux1OC596tVGMNRZ+x37uCd2WOkYDMymlRZgxZW5Z9JIK1cu+4hfWNQr3IPuD9HrZU84qcqKk+c/2954btkRbwXiVhM+7qhZraE6Ypit3i7Sb+LXx+8haPFol3A2SshVU0M+zX/wkzyBJAiPUd7wKv1s0DwnP+G/R2NBZGi1NvIsEybt8HZnbkyn+11Y9iGWRuwA4MR+g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1VNazBNa2k3NURsTlk3aHVnMUZ2TU5IbitMVmhOVnFKdHUyV3ZCVlZLOWJX?=
 =?utf-8?B?RUVRZHU4SHZUckpkeVZOaUpIclA5bk9ESmVQT3djRStPN0I3eUl0OGw3MEVK?=
 =?utf-8?B?MWFXN0c2UWg0SVhTVFB3NWwrMFR4bGlDM2RjSkZ0TGUwanFhb3d4anRpb2d3?=
 =?utf-8?B?Q1c2OHJYSi90YmtBQ1NPS3dac2JXV0tlUnYzbjRJU3BCeWIvbE5rbWNIMzZH?=
 =?utf-8?B?MFlZckJZblBNRUZGb0hTNmFQK1h0cFJYQWhnUGU5YmFyK1l2dUl2NC9HZEQv?=
 =?utf-8?B?Wmd2Q0dEbjRkUWg2NCtlb2o0S2cyNnFtRktFWktYczk3dDJtOUlnYmhkMmZj?=
 =?utf-8?B?MlRyeElnTCtOVmxCdGk4ekZoTWZPQ0lOOERCYUdBQXVZdVlqaVVIZjZ3Q1B3?=
 =?utf-8?B?TW1adkl3QXNJNWJydVFIdEIrR3dpVCtCN3NiRGdPVk45b3N6SVl0azlkYWRF?=
 =?utf-8?B?eFhKYUQ3MFZPL3Nud1hEQW5ZWkV6VzZSRUg5cWpSMk5aVFpDT0lYR29DQ0RQ?=
 =?utf-8?B?Si8wWHBjdXliNGhlMWxUZlBxUm5yMVpZKzd4TGdYTDlmUnNmTzYydWtYZGpp?=
 =?utf-8?B?aU9pSWdKa0hMQzQ4T1MyNHc1cG1TbkRGK0tYdk8yWURvTXZVZzdJVmczcGxR?=
 =?utf-8?B?ekY1NVUzTHJxU1hlVUtVa2xUUC9oY3czY0l5dnEvYUVrc3dIWWVwK0hJUGwv?=
 =?utf-8?B?Wlk3eGxHWkN3dUFyNHlNQkh2Vkh3SjZicU5wU0l0dnhFSWg5VFo5T2R5d3Bu?=
 =?utf-8?B?ZGI2V1VsT3M4aGxUdTZuem1QalBGdHhVL1AvNzNPOWFZa0xDekJOTUozRWxB?=
 =?utf-8?B?YmxTakptN25IRzlhUlpMY3hIanpYbkc5SUl2ZE9tdkVpMGp2OUxzRUFTeTFx?=
 =?utf-8?B?UUMvSTM4UVFtNmNmTWw2VGtMc2dsLytYelJOMlNObXlsWVJ6ZGExVTdiUmY2?=
 =?utf-8?B?b0FQaW9oTTNVMWNvWXFTSVdxM294V2EwTGRaNWp1UkY4NFBtOFNrYk9EcmdE?=
 =?utf-8?B?QzNONnkrc2QrSWJ3eE5SNllvWWxTd2FzVndESDNvWm5XWXZBSzEzR3J1WEJi?=
 =?utf-8?B?YlJMYUVQN2oyWGZjRzRpUWtDbmNkMGp0UjhYcWF5cWFYU1lLbXc4TEFBU0tP?=
 =?utf-8?B?VmZJdXFmQ0lpdnRRY1N2dUZYWjA0WUhCcUxWM2V4bUo1aTlBQUVLZEVsRWI4?=
 =?utf-8?B?OXZkMGF4VzR5ZjRLVjdlSi9FcVloYW1MOXhjTFVvTUM2R1dvb0toOEdoeFpM?=
 =?utf-8?B?bExmYzRTa1cwMm5tZ0ZCQVlkUEorcXFReGliVi9ncVB1dVc4ODF4U2NiSzRx?=
 =?utf-8?B?cm5iNEJ2aXgzcXcxWlY1UUF1WXJHTElqTnNMZmw4QjI0WlpjWWJ1WDRNT0k3?=
 =?utf-8?B?VGU4aUloWUw1T0xQUkhIZ3VZb2dTd2dJNklqdHVsRnFGVExzZS9EUGZOSlpq?=
 =?utf-8?B?WmJ6UEowR3FYN3VqcytNNENhRXoyOW1HT0cxaDdEWjZIODBtdmFrRzhwMTJh?=
 =?utf-8?B?V0dOZTEyV203MGhxdmxEUTRsWm5JSU5zeGE1VlVPRHlEUENwVWM3WG1SNnJB?=
 =?utf-8?B?THNTRnF1ZlRON05qWDNuNlBoeENoTXErT05hZW9QdEM1NVExYWV6ZUhrTklI?=
 =?utf-8?B?SFhrL3FWNG55SUYyWk9hUGRRc0JuMml5KzlvcnhtaVpEZ3FObktxNFhFYVYx?=
 =?utf-8?B?Zm9LU2g4TlF6U3NoelJlek02cGpMZ0ZmWGJJeTV6K2dFMXdmZ05SYy9aa2hE?=
 =?utf-8?B?M3N0MU52eTluUUFhOVZnYm0wSDdJUWxYOEZJcmc3MnZpUUhTQUV0OEQ5OGhN?=
 =?utf-8?B?M2tpOC91VDBrY0ZQak9vSmpGWG1TYTltdm9vNUNYS25ZRzIwUDlZSWxpZCs3?=
 =?utf-8?B?VFRTSkdFNHRjaGorSDlqTWpQcStIRFpuWVliaFFvaS8zS1owUFVJdFJtWE1x?=
 =?utf-8?B?emg2MUNuK1VUdEFlcGFjQndsajZQclYrWkhtVHZBUENsdFFmbmQwR3NpTmFU?=
 =?utf-8?B?Y0pXTExjZ2lqQ3p1eG15OVF2RXYxRUxXYXFuSkNjbUZNR3ppU21jRitUOWFE?=
 =?utf-8?B?L3M0TmVqdHVrUGgvTllWVnZBWTY3blhhRXgwbWpGVnJxU2pWNzF3UnpWS25X?=
 =?utf-8?B?Mm15NlZNdGFrUzZVOWVmVSsraHoxVENLd1UrbGljWTJIN3NsT2RVb3QyMFYv?=
 =?utf-8?B?SkZUT2UxVEhxdFY5RjRzazdoYXJGZjA4dXVJMEt4M0xPRVJ2SmU1RVFraE9l?=
 =?utf-8?B?VVVUbDRna3ByQklpZkNhL292clIybFRzMnU5RjhjSWRISkZ6SmQ4d3ExOTRq?=
 =?utf-8?B?SnN2WkcyQVpRMC9HUnJHSWdHQnJvZDBSZWYwbFZNbWdoSjdTekZMY1k0Nlp4?=
 =?utf-8?Q?+9KF74VhGHuzFifs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01430a13-3f6f-4055-2e5e-08df3daa8792
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:11:13.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw268wJqHtkPXscikgAQTQ6Y5KYm7MW8n1PqZnR0PIUvuFUztmKonL/6YzzHiQ2BYPVdnpmyDMlLyDLIlLseDrYztexikzswvgxD4uy0Lio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB373984

On 2026-11-06 21:48, sashiko-bot@kernel.org wrote:
> stale dl_bw_cpu used by dl_task_rebuild_cpu() after fallback migration
> dl_task_rebuild_cpu() disagrees with select_fallback_rq() on isolated CPUs

Right, both. In v5 the rebuild takes the CPU the task is on first, if it
is active and in the task's mask. A new patch after this one moves the
bandwidth and the record when a task must leave its CPU. That covers a
task that select_fallback_rq() places in another root domain. Its
selftest cases run with isolcpus=domain.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
