Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43342BCF4A
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198772; cv=fail; b=txXw0V3fOpVy0KCbtrbnrltPREE0uFBTgjoiC7bsbS9UhGPcSwZMIfGuiesD9tHysVDejpD9Ggfnn6b1NNuOTsNITzh+AXQ8mUU6J4aWsHyayr/SQTkZd7VLrUh/6UbvcCLiUnffHnWDmXEO2cr36Kt2bOsrnLqEJiJYSJB1OKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198772; c=relaxed/simple;
	bh=i2GTIfYe4L2RaMnOvyb3jQXBNz6Ld4Uj7toQV//Hbo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qo8gxrU5GEarexI+lzpkIgtGIjEKG0pJsvo+E/9P+H5qve12ytRcVCoNUKZRwaEpj0xXSxpysaXN0q0kgve4wwtbdbbgvj/1UTIWXhMaVnOzUUBZHk/8n9lHkGtAT+xWSGLO/1d64davdN2LH06kzixAaF/rc5tGPXImIhkxV9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uz+h9x1C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BSN1AIdx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uz+h9x1C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BSN1AIdx"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NAU8sR1631858;
	Fri, 23 Jan 2026 20:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aFNZOBetYuHjbH5MvM
	JiA4O3p22mTWdGiiaxKoye1JQ=; b=Uz+h9x1C5EIN+skOTD4j0xdckRDlTJiGw3
	2sE7gbrLpklRKdFHzAm0I25OeAd4xjUlqGM+rT79RmJ0GnG0NyeMkRAFFF2To2Ak
	lp1COI7VY+e+1p3PuDIpc+pYs63nDJ/ipvwIU7Nke7H9ZfOLFE2Do9sRhkSM/vtA
	dz9ER86Mtfs8osPHl6GWUR53yh5xkWJocp/FPyUHPxxUKAfK7eyMgT6+6JRpWWCj
	fFlUCRtsbPIdlxQutt8SFCaMMZn6cwj8QNbiLAl1kNK52Iyn2uF3QDTic5izLUoC
	lv1+7FPvjr3tPv7FqRQTheIZL9ZW5RLhjwBCE547i+CCe5pxbnlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2yq2yc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 20:04:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NIZroV013542;
	Fri, 23 Jan 2026 20:04:47 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4butv0vx6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 20:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV6G0SEokmH7MMykR3wf9RUYZiozD3uAog1qfHxLES+0hpezHX+5nLhi4Gpc7e7PHN+PT1v80AUzp1cRjnPcXqqqczIaY1IiRMYoN2Kpy6RDd6HUK7Pdra8b9rdR0uXN5bZF03bNTpkJ1dylfdcp+5kH5MzWjN3K9LCJXp5XxYN+yZc9DXR8f6SM2+pTC6BO464CA1MFBTXF3KKLGiXcb7nN3c6i8iUrv5eMrCqcU6UHXLYZxf0IPWe1HVNOR74gsF7+CSRu447DXzqPlPypAYQEHsKJtJZRK+cX0Z5UWZkFgKOR+HsrcV2z1ptf6lqlBPHIll3+eAUG5GuFy8sgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFNZOBetYuHjbH5MvMJiA4O3p22mTWdGiiaxKoye1JQ=;
 b=AB+KE6rQDrJIIPyWPNEfD9fKpFF9UDMtdXHXm1Kq+wiDX7AoZqoMvWr7AvDurVKMsRiRzSP3bsO20Pq6Ew7mOQAjzmGMzoF6zjqtbeGwJhp6l2GGdxLt7tYAKFlKEZWuQ+TN590lXdlIjSJTql8J0SZCFxF0uQkkM8MuVZaMMIbM47OVXZW0SKBomHBxTuoUO4LOnKGpYINdNxfEURFUNnkcRfTQFdOtu93VzJlwK0OT+mJKLADf8ZP15EFN+DM87PHptLI5nx0SNUe/FBvFk6xQoWRzLGS8f66+f1Dp93DCF+MvpRFeF+QGsT+KVSBtflhGRIJCXnw7Y15V0X5lEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFNZOBetYuHjbH5MvMJiA4O3p22mTWdGiiaxKoye1JQ=;
 b=BSN1AIdxjCpDWGlx8lZE18zMxV3Wg476wKJHQsAWxlfXw+eUewqcnV5H2SwEGXoLHckwVhybBi3vvMKBDeKci0y9EW7Gkh+6LIbeLCzG90lH7eQarYtH9bivaydbiPu4viVhA5t9uBO6nFlKPdgRBKbOBc5BG2vxBq45bmWifE4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM3PPF0275307EB.namprd10.prod.outlook.com (2603:10b6:f:fc00::c06) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 20:04:44 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 20:04:44 +0000
Date: Fri, 23 Jan 2026 20:04:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND v3 07/10] mm/vma: introduce helper struct + thread
 through exclusive lock fns
Message-ID: <c4d64bde-831d-4f3e-9b92-68c1beb70599@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <4f95671feac6b6d4cea3c53426c875f3fd8a8855.1769086312.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpEULwMTxAzxUdzfpHe2=+umXL6HFMvydkqW=tP8mB2ewg@mail.gmail.com>
 <c7c8158d-e360-4a29-9e48-f2b45b9ca147@lucifer.local>
 <CAJuCfpFbsAHr76ZfUEaRLzdxQMDjPEP+bsLNC35X9t53G_uqAg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFbsAHr76ZfUEaRLzdxQMDjPEP+bsLNC35X9t53G_uqAg@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM3PPF0275307EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 036cbb8c-29b7-4b64-53eb-08de5abaa6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jw8UaCrVfvhFnOy0q8EgRpx39R/E19wpNU1z/4d0l18FkndtcUTC/WmhX6V6?=
 =?us-ascii?Q?7xHnSUbt86GRZbM+1po5oKO5eDQT1iGbPmL+zTHTzEDKICaClRtttSBzZJB1?=
 =?us-ascii?Q?h5eGha6kcRAWOTLE3i1m+Kw2ax5ou6nSU0UytToaG0GhlfseMCNQXpJO3w/Z?=
 =?us-ascii?Q?ImCBkKnZ4gaw8NoqCgHPljquHiYvCdOv606IeKWlEx6evWbE9EHqe89NME/S?=
 =?us-ascii?Q?qstXzKQkYK+ZhAYPaJfJAwtxKEzJjtCvBhdhbRspzUkaw8k3N2R7TkkGSyhd?=
 =?us-ascii?Q?p/y9pAIletR5V0Ye9bYcYJuPIF0jXcA4GG5GbylBL1TWJtWQygYdPQFodbpF?=
 =?us-ascii?Q?N58kGdcSUQvoV+GDBfHJBWMeBMLglmpPw36+9/TZB2KeCi+Jx1e/H3tWMXic?=
 =?us-ascii?Q?IhgEi5gPgknAmMgXdqy+mtnxzQLNrGoE/w00BJ47oHfAecKBKW5fWkhDLQET?=
 =?us-ascii?Q?r/0sPpa++sp5mpus+eFdL4qpnYTXU2qZTkmshnkEjW+/N9mE50Fu1Oc6xmVf?=
 =?us-ascii?Q?0gxF7k3PDPgHgaQx4SrlzstIvjSJhd8mj+ea89zymIwqXjaZBWo/Ng2/Bxss?=
 =?us-ascii?Q?28zbxVvlYbFURnIXQHhzHxM/gm2dwkxbzhfu7LfH/CO4EgiFeKKadjpEG8M7?=
 =?us-ascii?Q?0/sXu6Lab9WLMWxa7FncS4C/LwJyzr6WrUGBQWlDjNM3slshUNjbNf1+vi9t?=
 =?us-ascii?Q?Ay+t4tGnxklD3cHLpstUzHmDxSTNlaEDHwirMpILRYL861J1rymXSdde6kjR?=
 =?us-ascii?Q?Syw6onjQ51a3owDyXJOfkB4Qk52ySJUASXrQ1MwRhinV7m2W17ZF9apZrpbD?=
 =?us-ascii?Q?iGfb9WIyiW2Qf65LctglcumejRgUsjI45tSpCFZ+//zSPuoBFtqqQq6J85cP?=
 =?us-ascii?Q?hxN33YUoXt5X/Oaf4qDJ1rOffQPiA8efYytpmI5vX4i3bDfSXtdLIRe0R9Xt?=
 =?us-ascii?Q?A2nQs9SOhLRx0RSJ7RN3B1Dwto74D6CIkz6sPkrjXFaj39u4D1LeKX3MF3sj?=
 =?us-ascii?Q?Z4HDh+m7LoX1kwQ2h9fGHMFMqx1m9HJfDYEJ0oTHvPpehIVofPeZzjhAC3Bk?=
 =?us-ascii?Q?9o60yxWPLsa43az1REfyEqUxI2/TnCac2MQDXhzeVBjE3gVdoWLRCmECrU6X?=
 =?us-ascii?Q?cjomDR1Rjlx1sdfsGBs+BjoVPQtGWhsLjkuCHwTMonQhFTXFs1GCFxUA6dkV?=
 =?us-ascii?Q?IbM4LXYTP73HYCX1gHZtiH5eVQyZpoL7B9jfPYjTvGda05EiILg/2S/tCNvz?=
 =?us-ascii?Q?MfH/JG/E3R3F7kujjlldPzOy2ilsp8MYsKEX5tjYdJungcKlIXwLCtiqFbY/?=
 =?us-ascii?Q?7s3pIbsU/VWp3r3xNXxcgPnGouSZviHXFTJPzdRdWwy3cFIrnwsA5qj4EVfY?=
 =?us-ascii?Q?zKkdb0CPgSQm9KDmYTTSntahXteKh/J4LhSqfAlFbywECD2z7kZzAtrNfHnd?=
 =?us-ascii?Q?1RNKDPjj2IDakYAv4Qv7RloKJW0b+oYVwWuamY3YKrmqF/pFGESkJ2i8SBrN?=
 =?us-ascii?Q?CxnqPSrcp9lk7/dcFvlUMFFL3aa6fPgQEvPh/BW5Btktuw8Q5zXYgVuV0SCW?=
 =?us-ascii?Q?LkSJlRA1Q4LDP4l8v0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xZImcNMr22CqEEjhyjGHBRFD2JpZQLymEuyWmfQpJa/wN5TLhYBioQsRbJK8?=
 =?us-ascii?Q?e7FR0lP+Ri4zd3oPZbwoBC8zBZ2xPk5Paij6O2UqSsBhVtfTNDEjEmkWWHx9?=
 =?us-ascii?Q?WxLvILke7h9K2/F38KoQeGluBR1HjmExmoBMyab3w0p8XwyANPyYtiDCihS2?=
 =?us-ascii?Q?XxOF0wcHleohMaEqsycy+q/3PdSImEsbpId7Rldrk/OVJM7ZN6A0d3wWmD+k?=
 =?us-ascii?Q?hXzrYQyt0N8PTwTNsRDZcdsKUgYJyds0r2KGj2RhlTz027rm0ZNcS6d4IEgW?=
 =?us-ascii?Q?gcZjAM0sxz+1qpX7wXMz/g7KVZSn6f98H79UmaIcgW6yDq1QRdDwgydkdF/D?=
 =?us-ascii?Q?TrWKQNQZRHPLyx+zRa/tx2S6RPhaAhFgJ+h+B+dRbHyES/O3FZ/ln8dJv3bt?=
 =?us-ascii?Q?YCYjWM+eF1THBNLJ8gxjQ0xjnPVp0X9Sbc2NGRSxfjjyOUx2oBFb8k0/v3Gt?=
 =?us-ascii?Q?ByYn68TWW0KKkkglunqzONd/b8bzShklz5po/9FEbAQXQjyIbxvnbjSxK0jI?=
 =?us-ascii?Q?2lV2GdSYYucndUSkQdYBErMm1Q1cXyzRlO/eava7B9JSieJ480DuIds/7n+B?=
 =?us-ascii?Q?ndlqhXS7bWYWOV9qPzzAisz3m7jSQxxxmPKX9tK34yGw43ZkMedx5lGlWzUs?=
 =?us-ascii?Q?OxZU5hlrDknJZsHZMyWxFXLfvRVJSZOA0pFY+GbvMwRgu5e+MilYf8r5tH2d?=
 =?us-ascii?Q?FdsjCErpctg2amJV2G3BFbuc0Z26U6X60ce+Wt/cokwjYewvQ2s2ljMalHRT?=
 =?us-ascii?Q?VQtqvqPauQBSBDGtzQv+E0YODXUJunWK+K/oJ7GC00rdcYN883EWx/e4oo3q?=
 =?us-ascii?Q?TVJV+VSqmmTF5ELeOzDGOkIGG1WAk6rf903bzirFtiTkv7gvximgcpPdQwj2?=
 =?us-ascii?Q?Ch8rYz3MW3VbSPbrk8zb7K21X1bMqhRB0aNMJ1ZP9NucG7IW7RrYHTovwo0M?=
 =?us-ascii?Q?ENP+2A5kStwXQsrrVywLDBkiLPN21MEuCr8BZR38VhbtI5601LMj7Kdw/jcG?=
 =?us-ascii?Q?DDMQRw+pHXdFuL3EuWvzq+RCiJzp5HCrcozQLNEfnD46kC9Ly9O/afkQOmO9?=
 =?us-ascii?Q?SdqLsudBVGJDnVl8/UnXF4vZuNrOYf7X8BGV8dbSgOj4mIUUY3J61p91z9Pw?=
 =?us-ascii?Q?Aj+9wlnD8151na9yfUvjif2V0zF0Oks7AbUQ8v6xvTy+G8arvX4egQBbawQZ?=
 =?us-ascii?Q?qrFB9YKmAH+hVIpezd2hpk6eZeAcDcM9T695B/B4QfB1S1XXvSpNdlrEau0M?=
 =?us-ascii?Q?2jw4GRvxpHDgIhiSXztqH+tOT9FLlxXTbZ12iA/DinpvLlM5qLYK+oAP24mh?=
 =?us-ascii?Q?KXieSKcgIhTNeS594lxJesUIYq0uIHz9lc9X+wgk2pBKJz3PTXwoJmIjDnzd?=
 =?us-ascii?Q?jL3ZJTN2aYSBTPRA7TZEVPDsRqPsZ9B8xiHzOjtqUn73tRWIv6zzI8CzxqVo?=
 =?us-ascii?Q?ROusCFBpo5P9TuoSBCR97gAud1Umy+xuaJAr9DsAxVZMmu8EEMBhGdlHdMdm?=
 =?us-ascii?Q?yUksf4b3nSiOCnsphCk9RqSrKLYSfhWyJYufku4yGXy3omvMxW2XG4PK6hKd?=
 =?us-ascii?Q?S8s9zBJjeXz+6Tm7YxrPLuezzq0obPDHKjJ/CfFC4g5GVBBp0apGH/8neW2v?=
 =?us-ascii?Q?8TEe5K1vro8HUHVFsZoLT7s9IjgZaqaSxRlGBjzCh0Ri7LhiQPI2YnP7Xu1U?=
 =?us-ascii?Q?E2+llPQYQ6Rb478R0bxfZgCdwvUoyXAErKxExolRemiNddOfP5VICba6E1mJ?=
 =?us-ascii?Q?XaKff12tt/zdly78ShiXnccuFYjpYS4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Caqj8aSr9sTRfgu2avietnLgj1Mt/3t5Q+zT3zES1UCrZDy7qtprkTJC1UZA+b7KA9lTMMRdE9oftACcBslsDPHtYXMZvtmyPfurGx+ZLWUxvzKzvTxfiYvaFX3mmhRqJlXpes6q/d43AVUdynKKhea1kYGmvexe4ILQllOetzpHu2SQ18+8eCsbZFO10RLFxFnmeCSFPRXVOIdTECYEe9Ge302Pj03g8Q63xBmfq8C7UtXtFo9jarhH/cHyuFwMpWU+7khF2ALZLZ2EW3+dz/aQeqvNzJhJTExKnGs24AnRFslggYSYi1LviOgG2ggEogB3zPny9Bz18pNwrkPt8M1BQkWCveWptSh+XwaTKQsADBXhbldGO8fkIDihu17CKFm5Pl+YOK8CNSEiZV9f+J2jbYX2sa+6XsAbf56Q5AgydeknNSbXNrWrtTpxHwHg8qS5Sbjx/689b9/Rfxp3cEPC9uCP7fIoy5Ag/yPLu2en/Qz5mR4BbzcOin3cyYJTnlGC1Lx6plZyO7baeNTgPq/SaamfHtsTUusfhxK98iPRqL8gtx7eke6/orp8ue13OKBmsh4NKuH/uiGUwFFh9aGIFMhHni5TOHrgnXAXFWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036cbb8c-29b7-4b64-53eb-08de5abaa6fe
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 20:04:44.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma5uAwAhiEiLvxrSrMQ38y0IBVSTBfM6+R/x42eqQqSAodjl6huiNIXNdhLPqmRCCThei69N9H02y26ECp+tr7GXawTR3Bc0cfvkWD1dWuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0275307EB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1MyBTYWx0ZWRfX8VNvzgR+cTr3
 PGCrADMDCI4NeIJyEp0PFXF6MWXIF4v+0UxmEEBbcMm8JynAU0f8RO8epGDiyBR2lurfKAG5VxR
 ifSqL54Z8uiJZ2VY0qC8uCPMEJDjOboao0rZGiCnW2rjEeW6ZgCr5zPlAVNp6ZuHfHMk+wN2AbO
 eoCY5Ag3q3YaLfZIb3bxFup9X/Tcim4fpLZq1FYmZuzDYxld+H9QKacpoBo2CLmfhuSFbcuMdAO
 Hi2fDSo0L+oGJ/mxhYMUg49f5L6n3nJn4BGGIfJ920SwNMhCPvOL8FL9phAdy/mnKi4RvnH0t8p
 a5tman5s7s2uNvLzbFKZLDqI2wFpkE9aDI47ahy6VvWNy9BET7HTdcsJZdDA31U8nP8cTJaoPY1
 FDrd/pVPJDfAGtihj3Kj8RRed+itkD5/0rbV7k87Y8NKYdwsPFTBumFoRbNJa03DwixxtnGZKao
 MeKjqr1PDv+2a5YvBNA==
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=6973d460 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JL-34Ru-T-camZ2jayQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QTIZBc-yQgwtxQM-ruJ7g6fxHB94hDBo
X-Proofpoint-GUID: QTIZBc-yQgwtxQM-ruJ7g6fxHB94hDBo

On Fri, Jan 23, 2026 at 11:34:25AM -0800, Suren Baghdasaryan wrote:
> > > >  int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
> > > >                 int state)
> > > >  {
> > > > -       int locked;
> > > > +       int err;
> > > > +       struct vma_exclude_readers_state ves = {
> > > > +               .vma = vma,
> > > > +               .state = state,
> > > > +       };
> > > >
> > > > -       locked = __vma_enter_exclusive_locked(vma, false, state);
> > > > -       if (locked < 0)
> > > > -               return locked;
> > > > +       err = __vma_enter_exclusive_locked(&ves);
> > > > +       if (err) {
> > > > +               WARN_ON_ONCE(ves.detached);
> > >
> > > I believe the above WARN_ON_ONCE() should stay inside of
> > > __vma_enter_exclusive_locked(). Its correctness depends on the
> > > implementation details of __vma_enter_exclusive_locked(). More
> >
> > Well this was kind of horrible in the original implementation, as you are
> > literally telling the function whether you are detaching or not, and only doing
> > this assert if you were not.
> >
> > That kind of 'if the caller is X do A, if the caller is Y do B' is really a code
> > smell, you should have X do the thing.
> >
> > > specifically, it is only correct because
> > > __vma_enter_exclusive_locked() returns 0 if the VMA is detached, even
> > > if there was a pending SIGKILL.
> >
> > Well it's a documented aspect of the function that we return 0 immediately on
> > detached state so I'm not sure that is an implementation detail?
> >
> > I significantly prefer having that here vs. 'if not detaching then assert if
> > detached' for people to scratch their heads over in the function.
> >
> > I think this detail is incorrect anyway, because:
> >
> >         if (err) {
> >                 if (__vma_exit_exclusive_locked(vma)) {
> >                         /*
> >                          * The wait failed, but the last reader went away
> >                          * as well. Tell the caller the VMA is detached.
> >                          */
> >                          WARN_ON_ONCE(!detaching);
> >                          err = 0;
> >                 }
> >                 ...
> >         }
> >
> > Implies - hey we're fine with err not being zero AND detaching right? In which
> > case reset the error?
> >
> > Except when detaching we set TASK_UNINTERRUPTIBLE? Which surely means we never
> > seen an error?
> >
> > Or do we?
> >
> > Either way it's something we handle differently based on _caller_. So it doesn't
> > belong in the function at all.
> >
> > It's certainly logic that's highly confusing and needs to be handled
> > differently.
>
> Just to be clear, I'm not defending the way it is done before your
> change, however the old check for "if not detaching then assert if

I mean you basically are since here I am trying to change it and you're
telling me not to, so you are definitely defending this.

> detached" makes more sense to me than "if
> __vma_enter_exclusive_locked() failed assert that we VMA is still
> attached". The latter one does not make logical sense to me. It's only

I don't understand what you're quoting here?

> correct because of the implementation detail of
> __vma_enter_exclusive_locked().

Except that implementation detail no longer exists?


Before:

         if (err) {
                 if (__vma_exit_exclusive_locked(vma)) {
                         /*
                          * The wait failed, but the last reader went away
                          * as well. Tell the caller the VMA is detached.
                          */
                          WARN_ON_ONCE(!detaching);
                          err = 0;
                 }
                 ...
         }

After:

	if (err) {
		__vma_end_exclude_readers(ves);
		return err;
	}

So now each caller receives an error _and decides what to do with it_.

In __vma_exclude_readers_for_detach():


	err = __vma_start_exclude_readers(&ves);
	if (!err && ves.exclusive) {
		...
	}
	/* If an error arose but we were detached anyway, we don't care. */
	WARN_ON_ONCE(!ves.detached);

Right that's pretty clear? We expect to be detached no matter what, and the
comment points out that, yeah, err could result in detachment.

In the __vma_start_write() path:

	err = __vma_start_exclude_readers(&ves);
	if (err) {
		WARN_ON_ONCE(ves.detached);
		return err;
	}

I mean, yes we don't expect to be detached when we're acquiring a write.

Honestly I've spent the past 6 hours responding to review for a series I
really didn't want to write in the first place, updating and testing
etc. as I go, and I've essentially accepted every single point of feedback.

So I'm a little frustrated at getting stuck on this issue.

So I'm afraid I'm going to send the v4 out as-is and we can have a v5 (or
ideally, a fix-patch) if we have to, but you definitely need to be more
convincing about this.

I might just be wrong and missing the point out of tiredness but, at this
stage, I'm not going to hold up the respin over this.

Thanks, Lorenzo
