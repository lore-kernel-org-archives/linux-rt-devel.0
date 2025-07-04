Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39BD2E5B0E
	for <linux-rt-devel@lists.linux.dev>; Fri,  4 Jul 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653117; cv=fail; b=hDPcGDKU217CTuJEQAALrq4SPA+NjperAEL9Qol1845KaCPk0OxMDtKx48E50HKMcg4GKVHtwZI+3tWPHlP5EgT0/ZkOg9WXopwm/jkGlL01iBy9ZOoi+vfJaekCti98ebxiK9tx45j/POCy9QFkffvRPgo25fDq6Q+/oJTnUEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653117; c=relaxed/simple;
	bh=n7Q38afqhSMrVUrtouPYqvSwq4NCCg1G8Y/HkY7wZF8=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Mqmhp7rDMn2vBZV+6u43xPJH3ZzrfVWPUZpBMW+aXmFgMMKpCvMi93JQgV+oPKIP6DRxg/5aZvfh2PPUwmLlTDJ5UOqn6jE671GQbNRfyw9rTKRE/Fkro+e+epXngm8J2S7nk7p3f3tVWX0SloQFndMhWPoqQMVFLZ5lfTcG0zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564I8PNL015910
	for <linux-rt-devel@lists.linux.dev>; Fri, 4 Jul 2025 11:18:35 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47jbp4f1vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Fri, 04 Jul 2025 11:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxo5AzhPXi9aNXm2NS8mBWAQy7iXluxdTPhx1xcJX00Qx9Zkne9yKCdw6jYq44OiOcoTsdJhL+p/5LuZbFf9HJSOpSOmuiONP3UOeC4p9bd/1hsxmbO6wc4fqfT1YixHWz1f4Kr8MK+CkZ7ehO0tPKuDgXDMyp4eCEwQ9Z960yL2sYpjUfm4Rckc7OLVQih7bEPt2tp4WdvwtW9Dl/KolvouIVJWgDZ9gY1O6gdBJsOCLeUjAI4i4jceeAvPYzSg736B/D7aDmqrTeC0UkfBl/W10j6WdMtPn2XRER8Ie5nyBpxIfn71x5k2FqL+0VkxJKYBOq8baRVhM6smgQfc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AfCRh1Sm74E4AWIxo9EZUUcukeFFjqvXY5BodtnXpQ=;
 b=XwjIuONBYXEZYCWhGmxCGP9jaCWqF5GxO0vlL5evHPAakSEOgRo4WMmnaaxF78ukrg5KNnrBUkhkt+Y9IV64Ala/QUw+cvVYv1ur/HZczAgjiw3Hw8QkfQO0BHVHUGBPlC2vahp/XQDaQ0vwqnyiN/wyJTPypsHq9c1wM4nbdmba3RPfMsxGVPw2EPQ5fSe9sLJGJd/RGU1PqYF7hfcG77MfQLovBFEmOqx7bODTiiIG2498QqDFX5MKUF1SGQqNf9diBH2Y6nIg1WRKGHwNI9+ILdqVHWbNjcUGZ2jcKpDcUuGTRMplwD9GoqjZkK6fIWLLWFpOvrnfOAu5OSGX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by PH3PPF801A91A7D.namprd11.prod.outlook.com (2603:10b6:518:1::d34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 4 Jul
 2025 18:18:31 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%5]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 18:18:30 +0000
Message-ID: <9e726dc8-e753-4f91-b3b2-9ea526e846b4@windriver.com>
Date: Fri, 4 Jul 2025 12:17:30 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rt-devel@lists.linux.dev
From: Chris Friesen <chris.friesen@windriver.com>
Subject: proper place to get up-to-date 6.12 with realtime patches?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|PH3PPF801A91A7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b555c6-b429-4499-c4d0-08ddbb272dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTc2SWgxM1VBbllvbUwrcGR4R0dkOUNTVlBKOXhCMjgvcW5JbGdsY3BJb3lH?=
 =?utf-8?B?VHNoemdMMXRkbmtCRkhSWWxzVHB2S1lwdmZQQnpFNzFEY1pYSkNEY2F5K1Yz?=
 =?utf-8?B?Nk0yRS9JMXVNSkRmTHdLRlFKZit0cmdTeWR2elJKWS9pdEpmQUVDVUVGd3R0?=
 =?utf-8?B?Q2hrT24zc28xVXBtVFlpTnlZdDBaamkvRnZDVllMeEJYWllyQ0RQa3dsV0pr?=
 =?utf-8?B?NWtqbVE4RmZOVUJXUFozNXllaE1nR2xjOVZOQnpHbGlIVDE1Z0NOOVpaK1Fl?=
 =?utf-8?B?VVdramJNU1ZNTnlkeVdDQURxM01na0RpdWYxOVNON2tZS2c2TVRicHdxNzVN?=
 =?utf-8?B?SlZ0dzFBM2ZDYk5qZkxXY1ZaZmdoYnROZkJQdDgzL0lDQmprN3VNR1pJVWVE?=
 =?utf-8?B?YTU2bnNDd1JhWHFCQWFraW5pZHp1VU05TWlDalNUMGFJa3NZbmhHbzVrcFYx?=
 =?utf-8?B?M1cxdFJJZkF3SGFkeUFJS25EQ3NQOU9CNk4wZHRKNHEyVE1GUDBWazIyeWtl?=
 =?utf-8?B?cVpRUGl2cnQ3VFBlVThHYWxLSkYrMFBhenUvK01pZ0xXaWlvclpMb1ZsNGQ1?=
 =?utf-8?B?cFVrUEdKYTBOUExxamg2T2VScTdNbVplZ0ZUQ1NyZWRPTVNlUWIzOCthMFNY?=
 =?utf-8?B?cHJVb2ppS3dqQlN6ZXNvYU5GRkFvbytRVUtEZTdUME1XbzNTWXI2MXJuTlRK?=
 =?utf-8?B?WUdyY1EzNkxQV3k1alR6cUNnRWExakpLUzM5MVk0UjFrL2FCeGVzeG8zSjNC?=
 =?utf-8?B?bkFYdTBpWUNkMi93T1V3dzNRSDlpVlUwajc0RjYvZHFaSHp2QlowVGZYMWRD?=
 =?utf-8?B?dGtvdHhJOHVSMDE4emtQblNIcG12SU9PZnZ0anZoZUJaMDhHMjA1YmxBeldJ?=
 =?utf-8?B?N1pyU2F0WHpTVE5KbFBhZmV5cWxrSHk5QlNZTU1vZ2RITHlqY2RpS0pjWE5W?=
 =?utf-8?B?b3R3a1pUREY4WVRXc29UWjZmcFRqRDZjcGFrMVo5MkZyZGtxeFgvUGhqUE9L?=
 =?utf-8?B?MVc0UzVodVVpN0l2RVpua1BCV1gzMDdyVGd3amVlU2tOY3p3L2VQaTVaOTNY?=
 =?utf-8?B?dDNZcUNZTTRQa091Q2txbmNadmZjZzlQbWQxbmZPRUFNQzgzUEdGRTZHdCtu?=
 =?utf-8?B?LzNJY3lsL25haXpmRkVHNjMxelV1blVLamxqNy9VMkJvOWVwQmZ2a1RUS3Fj?=
 =?utf-8?B?S1Y5a2pTMmtBKzJLaTI3cHdVbXY1bmhJM3VQNkdvVnR3R3hBRW43TCtSOXNi?=
 =?utf-8?B?bGVKaHYybnBkTi9ZcFNIRjh5ZFJ6NW9QMEJuT0NheUJEcDNuTXZvRlR2RDBp?=
 =?utf-8?B?d0k4SS9SL3FuVS9XbXJGTVBMOEtrZUp3cncydEpETm0rSlZONE1RYVJuTCtp?=
 =?utf-8?B?alF1MXBCaTM0c0VZbXBxM2NHTWk5UzQ4Q2FuZnRxZlhNQ3BzMW1lUTZYM1d6?=
 =?utf-8?B?TG5EUmNGc1Y0dkYyMWw5VTQxQUlua1N5MTJvajFKTU04dEhoa3M5SE5aQWRU?=
 =?utf-8?B?OWYvejB0ZDM3anhjOFpndmY0VHU2bDJFaW1iUmVrc0RrbXlXSUYrTWh6cXBF?=
 =?utf-8?B?WFlPMnd3YlN3bXAybVBIbjRpU0NDTHVDVXlOeWduS0pqVDFmTVBaSm1uYlhi?=
 =?utf-8?B?bXZrRlRKYTlITzB5cFR5TEU3SW9IZk1wZnZDWTQ5blRQNG9VQnVXNk5FcjNO?=
 =?utf-8?B?N0plamlibUgzeE96d0NDOHBlNGJ3ZTkvR0JqaVZwME5kTS85TTdrU1hQQzBK?=
 =?utf-8?B?WE84R1FDbVlzRXFnR2wwUjFPckZjeXVkUjdRTU1wd0FpSTY0WlhncnlkS0dp?=
 =?utf-8?B?SGsyaDRSWWtQN3FxeHVwUVBnRVV1VXhGaHBPdkJzK2hJNlpHZTRya0FTbkNV?=
 =?utf-8?B?ZWR0aTlNNFFiNURpZk1aSGtFejMvMjd0dUlPcURmOWFTQ1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWVWVzBWa2N4WXQwZFlITHR6aldsQVdYNFBhaGlwZ2N3SlVlQ2c1VDQvY01R?=
 =?utf-8?B?VEQvdUtYWW1mRUxidVZZMXlFa0dKMW5iWGRjUkJKeENHbmZHZHNvbGo1ZmYz?=
 =?utf-8?B?K1R2dzFVeTB6QTIzTytPaHJzcWF0SU15NTgzcEMyc2h3V1pZaXA5d0tjYkw0?=
 =?utf-8?B?M3dsSVJhOUFsOC84U1J4cGNoK1JMeUJrckZTQjQ2UXlNNjJycW8vdWRadUJp?=
 =?utf-8?B?d1RYRnpwVUc4RHNNd3FWNHBIV0JOcHBYT3FCZmQ1dXI5bVBINWNHVG1xdzB3?=
 =?utf-8?B?TkNFbXlYWkZqVVN4NDRXaUNZYnlFNHJOQWVFZG9tbFcrM2w3aWtkZjlGTi9o?=
 =?utf-8?B?a1JJUGxtQUk1cUVSbThNRzExeXIwUzg4b1B1bWJXYWRTZVg2dloxZ1lEVFJw?=
 =?utf-8?B?MjNpNnduZ2pYVkl1blJJb1R0WGVlTWtSSVZMblFBNjVWTllmRW9LR3A5OHBM?=
 =?utf-8?B?VXVNUncxblBjQmhOMUd4WEFNQ3M3MzFZbERMY00xVUVyeGhONXdVTS9YTzN4?=
 =?utf-8?B?ZDZhOWJ2S0FWL05wNVFVbzY0WVVhSHVVY3B6cTYzczlyWUZadUdrMFQwaHNx?=
 =?utf-8?B?bDRXMytSS0UzaUMrdmFTSnBkclBKdmlaTUxhWUxPVGQvODdzeUw1QUhGdnZG?=
 =?utf-8?B?QTVVanIrUG5tdG53VXVOQllpa3FjNjdEeHR0TzB3RnFRSHVjQTlSVGNwY2N5?=
 =?utf-8?B?a3YrcDluMDdYTk80ZzQ1TVdLTnY4cG5keW9LRlRITEVMOVZ0UGpSVnE0OVkz?=
 =?utf-8?B?ejU3eWk4Z0twbmQxcExwSHdjSitEUVl3STE4akJqekNObklZM2I4ZGFMSnZy?=
 =?utf-8?B?ZEZLa2dqeWx3ZjZuV1dWVWxxcDJ4ZXd3UE9Ob3FqbnRaNExWTGNIaEdvOFlm?=
 =?utf-8?B?Q3I3VGtVa2JKdUVYd0xrSmJGODQwaFVkUzBKUlNrRXladWhBcnpDM1AzeXJH?=
 =?utf-8?B?cXgrRDZUZW5BOS9OaGtMKzlHU0hReUlJQ3pFQ2kySFhVQTZzZFZLWENkTHJp?=
 =?utf-8?B?VGVBM1grSlZHeXNCTkNvdEhEeEZmb1lDNytUWFM0QlhLNnRQRnVHRkVsdUZX?=
 =?utf-8?B?NlhkZTQrQ2lqaUpvSFlJREMvSGhwS241Ym8reEg3WVlJVjQrdWJCQXA3RURm?=
 =?utf-8?B?VEgyeWxXbXdDRExqZXU0WUwwNFpFVlY3WTgzNkMzSWo4NEVkNVFDQ1ZqRGFO?=
 =?utf-8?B?ckZtbk9nSnZLVlVpTHM4R2cyZXV4dXhrdC82dUlBdHlmUjB5VzZkeHBFTEtZ?=
 =?utf-8?B?MndhdEQrSE9HK3AvTHkvTFpic1l3dEdtTzFVVWJabVhhenJCbk5SQmprU1Mr?=
 =?utf-8?B?SG1XL2JXWEtKZ0RpbVpPdFVWa0QrVFErL290S01RWjNnRmJKM3hnTkxILytu?=
 =?utf-8?B?UFBwZTI5dzFYTVJhSHBhSHp4UHBWTnZJaGs5Qmo4SFA5bHJoTlNTV3BRYnZa?=
 =?utf-8?B?Q055NFJFaUxEMHpwbkQ3ZHk1bEJ0aVViUHlGNDRWT1NvWmppaWtUTVRoZS84?=
 =?utf-8?B?c0dlYlRNUEJTdStHSTZNN1FyM3g1WHB5emczZUFUaHNObTlRVnpnVG5oNHhM?=
 =?utf-8?B?R0Y5Mmh1aGRWd0ZUQUdISi9HSHQwZVYvSkdaUGEzNGM2N01INTR0MU1rNFEx?=
 =?utf-8?B?ZHV2SDNSUEtlclU2SDJWREhKbXFiRWR5ZndXa0RmaDJva1hEck5jRjlSanJP?=
 =?utf-8?B?NFdDUllGMmNaSkFtdTB6WDA0bHgwRk9wRjg2UElDQU13d3FiMUF6eFpFb00x?=
 =?utf-8?B?M2hkeGErbkE0THhOUWxoaVBQazZQaStWTWo1TE9CSmpNN2R4dEt3bTZyczd0?=
 =?utf-8?B?YndMYXFPaUZFbzVuajdzcTRCa0YwZUEyR0p5Tjk3azRhdzdPb0szaFJuRDl1?=
 =?utf-8?B?aDd5VnBYODRFd2pFcjdTbTJJQStLNXR1ZW50a3htSU94b25DUFhBdHRodGlu?=
 =?utf-8?B?OFA5Mnp6RURiMXdteXkzT2VKd21kQ2ZyajkwYXNnZ0QvZm0vOVpKQ0w2OWVT?=
 =?utf-8?B?S1E5R3N4YTRCK2x0MHRPSmRnbGkycDhJMGlFU25QbVVjMGE2NktUUDVuNUtM?=
 =?utf-8?B?dk9NVzZXUURDTmgxZVI1dzFvWEgzekpHcFJ6ZmpSc0hUTmd3V2NuNlJ3MjMr?=
 =?utf-8?B?OGgrZmNvaGowQi9HUWxSeWx5R0tuSzZueHpmUnpScksyRkVnSEFwcmpaTlFv?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b555c6-b429-4499-c4d0-08ddbb272dcb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 18:18:30.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FkP0HDuRbTgcquEzJt3e9SaQxZYLpUp6bG2keWQhg8Qswf1bOOGREf2C37GOXMTYlgsBjAR3XNVjt3aLlHu9+sq2jqFQ8WnOrdWCC4tlZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF801A91A7D
X-Proofpoint-GUID: v00q9s-JlWNKMuC_DPZeEltKJD2Bovqv
X-Proofpoint-ORIG-GUID: v00q9s-JlWNKMuC_DPZeEltKJD2Bovqv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEzOCBTYWx0ZWRfXwGKI5iwqXWBI tdUIm9aNYV0F2GKm+zOgZqaXcqF87Llyp5xGBG7Vvae+CzGMB0+JWoybSUdumTThUD8jxJ8O9HK u+ODNqWf1Qt0xP8X6yl+wVZ3UXHv69QsM2sTiN+8TSia5or7tbAHqjgVzEXeFQjL+JvGKM69Hw8
 JcPg2y7X3ml4SpXGurcft2NY3IEIlBMCfCR9h7rslT3i3/ULVG2DYwT38BEI67tCwgC7US6VB2u dsvBAFaN4FkhRasdlPW+NqqCP2owadyoqpOBgnEVGfmiuoMm0q/rJpbdTlvwSz8dIYCUZqiQc6A 9T5NsJuwDl13AHuD1STFP0UUMT3f4UkA+a+kLvMNwRcp3/OnODLA2wHZdp0R9JAjak6r8BjMQgx
 mtgfGKn6dLWd/SH3TD3tQpnGt0RtcaZ18mq6nyQpjckClFqSijfb1qi0xGDnlvr/LtUYD52S
X-Authority-Analysis: v=2.4 cv=JMg7s9Kb c=1 sm=1 tr=0 ts=68681afa cx=c_pps a=g+dQH1R+REXWkVycoqRBYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=auDmylFpirK1TUdR1aMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=653 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507040138

I'm a little confused about the intent of the 
linux-rt-devel/linux-6.12.y-rt git repo relative to the 
linux-stable/linux-6.12.y repo.

Given that the realtime patches are merged into mainline in 6.12, what's 
the point of linux-rt-devel/linux-6.12.y-rt ?   Is it just for changes 
that aren't yet mature enough to make it into mainline?

Please CC me on reply, I'm not subscribed to the list.

Thanks,
Chris
