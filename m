Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7B258CD0
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Jan 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856412; cv=fail; b=RATkhAoQnqLYBYklCcadDFk52NnFBRSvAW00WU7ElvssZ9jeXWAoBpzOjCklPv+VJoUAzkVvcOmP3ds/jbP3Pk+bJVOGwhOz05qp9ZtOzdExhB8rLEChPkVHax/bR9Y87mh1//Ta21vT4J4OIsNFkYxDJ/fntAeSvZEKfK11l+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856412; c=relaxed/simple;
	bh=ToV2o5zAvmlP5ln+rNVhPlI6WorNiGnKUFfAqyzOtZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWoM4O1OReXfXLKHHVy0DVvVSUoNw+Mvoshz4/4ezuPWLyjjhqF+WJ27ssbljaINaZuk/nZoD6C/7PrUni8L0R8KfERH1h/xPuGJnr0Tz4sQYxh0WVQ1M6St4JF5vjYaxRFWrcpNMgvXXZrcQL+GE2bcd6MqIgaxyJoHkB21sbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KNXmVQp8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yyEMPVfy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KNXmVQp8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yyEMPVfy"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDp0m1035384;
	Mon, 19 Jan 2026 20:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v1/REBbzInfrgvnoAwKhqaOtDOsyNSo43cuCetnV7U0=; b=
	KNXmVQp8aJynDwSGj5HypUNgecvbaJGB5EB4O26I90Ff6oDEbxgWs8SVBPk0JRqn
	/mYGnUXdsdW16/yVzz0W7nqUqetPOKoZRH8mOQrO5aNLUdDPHzOMZBHfw2FgPXEM
	wuUsP+0LjOU20kJc3QDv9uMSRajVyv8IDm5gWFW36fngRunfcQSlXF3ASMsGIDdk
	nu4+hPF2171RmIACGXq6XxzONLyBU6Ur0otWgu10t47AmogZdTDhctsW9RMxUkKD
	MsOtz5ritj9Oa1Y8GRz9FsVx6Is1C0F8e+igPT+XiTnc6euRWiXDRVE9XhjEveex
	ZUICRRPix9Wp8JIe2RTIeA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vtr0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 20:59:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JHsVqG008426;
	Mon, 19 Jan 2026 20:59:46 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8sfx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 20:59:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDxgYEdALEtxB2fVe6pjv8/XFKYfF3TatM6UBJacCEyzFHnTDe59HlNHL9gI5IC8GM5vROCIxTCdduIg7RZrvSJyF0ZrjvvxwLe/NJSOhN7enAO1rJ0Il9RRcZXXq80S56NKrwV+PIz5hMEWgkpWEJihVsj/UGCMg86GVjLP1kY0/a7Z+EVE06z9OXN76QDQwOhdAXppkMqW8JVYL1rnBnj9gN+WSQKJfAiTa1j0VKLiwzJNM/8jF8v1N9++3FeS8RU4ynTMwxmwd+PFp6u/Brd/qvMYuyTTRzVG8r4gzwxp94oAj4kJBjhhHoKqQrUq1W3Q4NijUvVwBojkInSR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1/REBbzInfrgvnoAwKhqaOtDOsyNSo43cuCetnV7U0=;
 b=M5OnZVeQ5kekUaWKyimxTUySunONCskmnuvPILQ+B8/gNgEnDgbTMsoXGQflII3I3BifkK+peG+0VUgMYPnUddcqRd6JV1Z/FNBcnRTaEja2vYGKtYABMmtrTY1WwYDuXBPbagkIzEqk6Yy8mwoD0yixivsHbe74Bop60/6VEHOZA8eLvijrZPcZeIWFhQozVAo3jeWgKR/xlzrcmE4I30FwinS8dsvAMPS+2b3NmmrJdMV8THx+VTnbwJizPknPLHLmWDk176I8/9GHyfn1eUO1fkKskZECGzyAGp3NJkNoPqMtaB4s8tFyGaRBcbJC8RHFIQd/O5QuiO1b44WGIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1/REBbzInfrgvnoAwKhqaOtDOsyNSo43cuCetnV7U0=;
 b=yyEMPVfyoMNNsV/jEuzhCXppgTQ6WqYjwym/XGa/i5HuZbjxhSt2/UItZpuX/LxJ8C5BTG3cYk7nANrE6S4+M3niStMiL2Vj5tNzORJ6BBG+kpIB3V5kTnh1ysuFG9fDckOteo/ujn4qNmVzAM1OscgjnpdB9iyaZVuzo05WCQ4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:59:42 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 20:59:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/2] mm/vma: use lockdep where we can, reduce duplication
Date: Mon, 19 Jan 2026 20:59:39 +0000
Message-ID: <bd410fd91d22eef37f9b617327cafce33b267b09.1768855783.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768855783.git.lorenzo.stoakes@oracle.com>
References: <cover.1768855783.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: f830b694-f460-4ff9-408d-08de579dab29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0R5trK2rQChE5JV3N9wASwzI2qscDtuNvU1eC/3SxalFtd1Kshnj++O3u+9U?=
 =?us-ascii?Q?WH5rqxXxiUqKqT2SIo6KXcrMat3U0CRlpPcETEZw+7ji5UJ7LBhGgz482mur?=
 =?us-ascii?Q?Sw7D+oVkL2QSF4gId/C1FIshqh9vObNFa0CU+qlQ9kwFIu5JHntORfo9a1R7?=
 =?us-ascii?Q?OgcactwhIIFxcM6+uAR0SHHQgNDCHJU/iqd1gpHHujLIq1SNzOEMSzE4LEyD?=
 =?us-ascii?Q?d5AGeXukOG7xb3yzuXKlCA+ByKSoWrZKGF3HuQwueWxuOkl5tAUi2n0hlbHR?=
 =?us-ascii?Q?1+Tpr7htnaRbBp+dTSSPusdHmjxJusIOHzGRDY2w9kBxu5DUEcJgyFIqSziu?=
 =?us-ascii?Q?3euGeYaZlLREb3OP8wLXqeJfbvcNxEvlXJO/R0eqVdqKBwyNMYRa/11nTIJT?=
 =?us-ascii?Q?rvb0OHjSuc5qd0vvVrqxFoHpGkiWjzvXqVPe9BulzhHqokqncwOOzH5DNHec?=
 =?us-ascii?Q?DBbMeCwZbySgw8sZcRvpJNhQDvkYZK6U6AUqRmDGTctnGmBB0+WsE7QHS25c?=
 =?us-ascii?Q?ogWy3/9GKCye59oA38UvOpmh9J+pKS52KtWnRheUulXD6H8D7cAhWsizEq2Z?=
 =?us-ascii?Q?MVWUOjvIEPl10NJsH/L4gHdHOC7FRPaV8DPI8BEI40C9zbG7e0he9YFLur01?=
 =?us-ascii?Q?BOMGo6gTQD3RbQJTZhSivXGs2rP//00+EXGjCwh+SgxLUTJuPDf5SK8UIQWi?=
 =?us-ascii?Q?WRuMuS4r9+fv//mU8CcBB6Pi+iVKG05Fn6axAi4YMo29AnfmwoK+JnrXEhN9?=
 =?us-ascii?Q?lN04uDoYGUpf7HloTf02MXFkb9ps1XvXYAuzeoMeg9n0v5kqAYb2G5xKebuV?=
 =?us-ascii?Q?vYkBd/rMW+nyuVCaIngdrtQQt9nunu1SXdDTS0zBwcmnezUaXtPce4EG0COb?=
 =?us-ascii?Q?lflZnCiG9XY6EWD9xQwiYsQAjCjOF8R9/1sfjfrfKywutjp7n7Z7L/2FchBW?=
 =?us-ascii?Q?6Nw9xjiBbrzkj8zAZB5Dy3OTGdD02YglmpGOpUJLRQISyHALwxPUvPq7IgRq?=
 =?us-ascii?Q?H+kH+a17sbu8t0QiSp0dGFmrGUutBjS0j/2j6Icg5vRDgmZc/6OalkrGKgWW?=
 =?us-ascii?Q?Z1ARiqcHJYsBJy0PUXK8vx8ErTgWlK6YCh5w8NKVux49mlnWJA8JQO2Sx+nS?=
 =?us-ascii?Q?SF6m6YdgtVtFqOw+Z0mNYFBP1OTl4K/GNsyQaL44fcXdHb0J2rvnIU7axueV?=
 =?us-ascii?Q?Kdl7PjNN3iGoyNzN8kC51UKITUIVEgpuTYV//1M/3qfVb2nt3s63rUEXwbkK?=
 =?us-ascii?Q?RRGaydZ6y9VCX2TDR9vQZSDfjjmSylj+vplrdfrBIVhIZL7F0UC1jlrK92XS?=
 =?us-ascii?Q?d4jHCH2ulIbQxh/I+YMjGLlBwVMPY6NboitlGxvmrE1+3k6o1xjL/YMLGns9?=
 =?us-ascii?Q?BStYHuvL5enNuSX8mMwULMciOjduIq9nOL2bjEPnPKluDGiCDGRuhRgz67Qd?=
 =?us-ascii?Q?RwVCuE1gBv/wWCkUmOlK3SVxS91rzcSSU8RAvjHkT2o+tjcPkwzYHVjTpx31?=
 =?us-ascii?Q?icXql69oJE1RV+IhqlVl0QJHRrPjIbsaPE8Yz9B94SmmqNxRMm23rHkaaNzO?=
 =?us-ascii?Q?Hq5+przH9zkxMICnOFM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIJTF91wfDHzx/U65kpBUak5nLl+uoJYDuFHnBAHwdK7AHFCnoV9LyIjfOIe?=
 =?us-ascii?Q?Cobs8Vxs8G+BXeUVcYtSg6Hbdg1RCnOGSKN1ZDf3j86RjYOkU68PsnhTOdCH?=
 =?us-ascii?Q?1fwAWQswAr5jJqukwyEF3hlKtmPxR7yLJr0IdETU6fNK8rrHdBo6aKbJCrGY?=
 =?us-ascii?Q?juF4lAwQbxc/RRiPjBzKuy0yYPhTPyVDnCXBAAvYu5/EJi+joFwqybR93yDJ?=
 =?us-ascii?Q?/LSSbLOl7xSuPZ6My5Tn//mqzU6hBc8g8bao36HDi8gPzKW66vSuU5j/IXLv?=
 =?us-ascii?Q?qV6BywwPZ7+lqLG/xoBFqHmZoEfTK/3nFnF7Szgy4G+t3vQV7xFmCs5tosFA?=
 =?us-ascii?Q?kELWAq0qw7Pz+DrNA5gmYMhZqVE+9hkxIUUoi1+uKn2x7sdv0bhA5we2MsQh?=
 =?us-ascii?Q?ITpPqKcOXHWGy07n9VujsqlJPKpDzwBfqVii5PCnQE9L+18O+Nk0V2TzOCE0?=
 =?us-ascii?Q?EsRxbH0PsQpK+7Zs3R8QGYX6+knB2836/Rpe7wP3LAfULQdGl/WyDpk/rux6?=
 =?us-ascii?Q?GOb59Bs52ON9bh2gGHV7j6XW+U2J31YKZFKRJLZx3NZWRoNUM3o7f80bTK/t?=
 =?us-ascii?Q?7xPnigVMBBlJxaSSjuKTWn5slvbBTtVWYfEh1kqc5b1Zzx8SddxAY+/mwJ/I?=
 =?us-ascii?Q?J37xtDHHtw63MRaKqqq1rfd4sWssT6vH4YKbWLR8/5IV2psP6IDhASrFe1KN?=
 =?us-ascii?Q?kmL+8y3EPTD8WN4ysjeeaUkJOeeA2eUk9fEnI2T/Xebk6ztEyJJ/wcLk4udi?=
 =?us-ascii?Q?mJGDzHCu3tqUJ1sgkRiENqhnN5s1Zcujx+vCTOnytckpZ8iUUMb2acXMOuvD?=
 =?us-ascii?Q?gHFkGOchuiAdMh2XHQy2jsMObRMYCKuc2UV5OYOCN+WvCwwFpIoQropHqOXG?=
 =?us-ascii?Q?FpphrD1uoClX7Lo2PcivHx91B+KH1+S3Ysy+dlzIXbqIfck9dVkvpSYVyyCK?=
 =?us-ascii?Q?jGoq23BTl73WaqcukuNL707hrLToDcx/l3jKjaqPUAZGl8V40R8bGZm7gtaB?=
 =?us-ascii?Q?jMULpPUt3d+TGzSqJEyP7cNC0+WxHcot10B+ej3ERgOVR2wYQbAnpPX3docm?=
 =?us-ascii?Q?fcIlZparfwZLNJJul9wvcvLLMdBZl57bdhvyr7ngJCaPhMb+0fUkx8FUIoaa?=
 =?us-ascii?Q?6zrSQoqtf5iguAnTuU/2bs1rK3zhIjR1fs6dIpdwc1YTisLbEkwf4ez5Lsye?=
 =?us-ascii?Q?AH5mY6yxee74Rj6zXvcwm6LKB0AY/pw8thLR5sR1p9V4dR0MFn17iqpJyMME?=
 =?us-ascii?Q?V6J+2TK3R+/oU7m94gUVJ1uS4X5gI3rF/C4EXDY7HS/NsfiSLQYCS7lLCpbH?=
 =?us-ascii?Q?5P0qQ8fP5pxHRRGjs4EvaJWbvuVq/vBalsCTQuH+MoCL6h1ukPdAF1RZFMoZ?=
 =?us-ascii?Q?PzDLfyi6A8cVMuKeJopUWa4E4g0/M5U/W7a5oJztR6Wek39ROZvtjK6VI3Km?=
 =?us-ascii?Q?gc1MjE+E2CkfyojucPLpjrk7WF4VVUa+fR1TrWRckH34HSVf4/VTGaEFTC0f?=
 =?us-ascii?Q?abPcrdGvq2GkJj7NiDnPdry+FnMyam8gKZ1uadgk4xle1xMukubmUAuAZzQx?=
 =?us-ascii?Q?xuFrcDYeToUTGWyGAixlGu+UJXBO19GTKdeViYa2s3Z9fSw9imkwgg0y+5ua?=
 =?us-ascii?Q?49hD42gfmOJg5QPrGkbY81n+wVEbkk+RwGQQMre1u6ztgoCbnpgsD70HOAsY?=
 =?us-ascii?Q?35PXfH88AMDU9hHLIUN2WK+0nJ6AeROEikXaTUnoL9ULqxQwj0OyapiVbvdr?=
 =?us-ascii?Q?zt1bJQbFaWmbptNvYDQREu+afKqKOXY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jV0VgwutBn8sv8Uqpf/89CBiCe2FgJ2BdEBjn+YLY9bz9xvkEI5iDhd7+qsaL6hncTifiYLw35dIkEuWpNczH3RTKTBGjR98djXT9NTtlAJw1u+pxndbN1KuyewlRVwQWqRXrTA+XNJZaTPoUU91x+SMVEn8Ts8bPyChgNjoEeyoW7pim1w2uZHm8klMA3hxk9QxMvt2TbT+gOmMcuUtRhoHCIN4ZA2hVXdoPiD3SOsEhi6EahaTNjK9ZQOQU4yEG1eU8gQFSb2lwbbALL5qn60k5skDlFnRd/XJEXzc+D7SbuqVJ9tvwm348cK7le9Jl9LOAcAgFuQyvyveGxyjo3pyZLcPjw9mGxaWyeZuySz9FexTTXUtoEiVBymwKMAfbd28YJk5iffRKRHBsaVlGWKWI8hQFzWVyMKtE5ynZB3V5+iZZDSzGmN8NiAa6E5rCi/eMoCFE4TItIPfdhp4aOJUeQyOw5Z80sXr+z6VVZFSA3vKNJsSo845+ZKBpgJgttQiAk6RtlsN9PIozqdO+zTANIxdxHBr58RXSN3qR3jtcuXNuF89/QrMXsNrMK9vHDMxK4MWDGVK9EAqTqk224zzmvYlmWrYSU2HSM3sXFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f830b694-f460-4ff9-408d-08de579dab29
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:59:42.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+gIAHhSEhxjLHaIyf4x2q2jo/XSZT2iZpA/OIqOo2NCL2hkKaAJodd4RzLClk8H7Ismh9XN4q/vXnXV/k1xlcSg9NeQ0s/mo0z9pGv9ZSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190175
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696e9b43 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=1qjnsRwpk7GXaf-aRIEA:9
X-Proofpoint-GUID: jK-s32U9Pq17pET1uzIiwTsI4CJoZjXg
X-Proofpoint-ORIG-GUID: jK-s32U9Pq17pET1uzIiwTsI4CJoZjXg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE3NSBTYWx0ZWRfXx31Fk8Z4N5+R
 ku1swvmOphxNqInO2awYx6g0xXau9ipycYyXPHEvU9gG8reIr5gTXR3ziJRp1KjqfThDAjBlYBi
 3KdFaOIKNjH1vhq7IyGN7bWSMTbjs7lp8ffdSQZ4/Nl0ooGqicUMaXs0y/THpe4BPZmfwybQkyv
 2/f76L9dtESJ+rluCRP7GcfiXhR9D7itFOYprU4qOkF+0Uy/2Dilo6cGGjC/DYQ+4QIUWWPVkrd
 qlFpstqjk3JM46IRtXhjvTeGkXTA47QCZOH1BbIdevir+29afG2uZ+tMepjSzbEkMJ4eTz/Dkds
 1GWEGzy5D7O47ws8DT6e+rblTANORdnzNU9hKzv1BX82DVfl9W6Cly0Hf0Q3ySBGUn0rZfPgpo1
 WB5rXlBiTNbol1WnEByJp/y66lpIF1mJYS8/j6x13PACHk/ZqYjmgmYs6GVA2TWwDNvxU68/KI2
 SCZ2LaZmdiSfN3xt56A==

We introduce vma_is_read_locked(), which must deal with the case in which
VMA write lock sets refcnt to VMA_LOCK_OFFSET or VMA_LOCK_OFFSET +
1. Luckily is_vma_writer_only() already exists which we can use to check
this.

We then try to make vma_assert_locked() use lockdep as far as we can.

Unfortunately the VMA lock implementation does not even try to track VMA
write locks using lockdep, so we cannot track the lock this way.

This is less egregious than it might seem as VMA write locks are predicated
on mmap write locks, which we do lockdep assert.

vma_assert_write_locked() already asserts the mmap write lock is taken so
we get that checked implicitly.

However for read locks we do indeed use lockdup, via rwsem_acquire_read()
called in vma_start_read() and rwsem_release_read() called in
vma_refcount_put() called in turn by vma_end_read().

Therefore we perform a lockdep assertion if the VMA is known to be
read-locked.

If it is write-locked, we assert the mmap lock instead, with a lockdep
check if lockdep is enabled.

If lockdep is not enabled, we just check that locks are in place.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mmap_lock.h | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index b50416fbba20..6979222882f1 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -236,6 +236,13 @@ int vma_start_write_killable(struct vm_area_struct *vma)
 	return __vma_start_write(vma, mm_lock_seq, TASK_KILLABLE);
 }
 
+static inline bool vma_is_read_locked(const struct vm_area_struct *vma)
+{
+	const unsigned int refcnt = refcount_read(&vma->vm_refcnt);
+
+	return refcnt > 1 && !is_vma_writer_only(refcnt);
+}
+
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 	unsigned int mm_lock_seq;
@@ -243,12 +250,31 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
 
+/**
+ * vma_assert_locked() - Assert that @vma is either read or write locked and
+ * that we have ownership of that lock (if lockdep is enabled).
+ * @vma: The VMA we assert.
+ *
+ * If lockdep is enabled, we ensure ownership of the VMA lock. Otherwise we
+ * assert that we are VMA write-locked, which implicitly asserts that we hold
+ * the mmap write lock.
+ */
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	unsigned int mm_lock_seq;
-
-	VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
-		      !__is_vma_write_locked(vma, &mm_lock_seq), vma);
+	/*
+	 * VMA locks currently only utilise lockdep for read locks, as
+	 * vma_end_write_all() releases an unknown number of VMA write locks and
+	 * we don't currently walk the maple tree to identify which locks are
+	 * released even under CONFIG_LOCKDEP.
+	 *
+	 * However, VMA write locks are predicated on an mmap write lock, which
+	 * we DO track under lockdep, and which vma_assert_write_locked()
+	 * asserts.
+	 */
+	if (vma_is_read_locked(vma))
+		lockdep_assert(lock_is_held(&vma->vmlock_dep_map));
+	else
+		vma_assert_write_locked(vma);
 }
 
 static inline bool vma_is_attached(struct vm_area_struct *vma)
-- 
2.52.0

