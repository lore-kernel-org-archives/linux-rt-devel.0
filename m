Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4916826E165
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580527; cv=fail; b=UPhh6AdUzaD5Juzy2ZRyKv569bmJ1A6VJFoxcwjM/RHcpPeGfOA3IdR43iGviKdY3h3ncRibPR5jiRZDOznAFdoYHvP6X9e8dkaU+V3InzvGcCX1vonpKZGa2L+VZBRi23QKFOZ2sqU2zfp5Je1uPU1zjRtPM+4Il89oEzOI464=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580527; c=relaxed/simple;
	bh=qzfkEul1+kGlWMMIangxWYp9Y8XQEapSar+yjtkzGGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XHdnRlX505kNFRX1Bf3ttVZCHzettDT8pgRwZotNTe13A7Dadf3MQgGkdEecWCWoz+bIjOlQWCKuy4qMefzqtypYm5YsZWdg2h5FpVF9fNeARxdPGsCH8F7IVsiV4lTvmeWGTiC0wVKUL6zBf5qVss1J2EMIwRovApOP3ilR/jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iZLbRzKw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q0OiOP9s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iZLbRzKw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q0OiOP9s"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GEb3K21817896;
	Fri, 16 Jan 2026 16:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2onjv5z+ppb4TSpHEQ
	84JNNJRw87w6BmX4Xf1VoDePE=; b=iZLbRzKwmDmNYjUmPwYxw/VeUEKnjt/shy
	G2NPer2RrZtMThKg9Ti/Wxos1EYIPXMQmy7pGLOCqzxNceqGKQ2/PMe1HjptRV3U
	gpPuq4zYAxx/6rdqmRQYQxWkCu+PGXhFgiaEGEOW5dCfu1zGH/ltowSm6qrxQnhd
	HVK/rzN8xrfFk/FRTxm2c8TW4u01u+5jC9sg+PMnsIRbOWmzwEHsdYwS0J2MPbPS
	7XU7wTDCbKozc/z+guv/jA8kDrwctb/d51ARmBU/UV6f8tKFOaGxmm+yjk1otTbR
	g9UCZrGR4VArM1fDFnSJE4UfR363fNZ2VOsQ7eAwqTv+tMYNUS9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp5d8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 16:21:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GFl3vA035247;
	Fri, 16 Jan 2026 16:21:34 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7d3d37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 16:21:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJ8SDS5foYF2sFpy1VpOCGQC/WG15q8GgbrqzAmYwbDjZjZyxPlHXMGnGGwkA97RLX9dCFU3ClC6CRxqSW3ZUeDjhW+TiCEFIQc8hbxCPC0sX24Fr4H+fWN8LN6QxDWWD12MCfmcvIDqduokBPQWBudmPHIKIeCL+KSk/ph5wRmV05Ot+1tQXhuxNU7zOreVxdVKjMYnwgQxT3kQVbV//ZItpD2c375+ShOhCOslGB4YgOBawDIHPUO6QZEgmBEXFBV3vEDibGq7hy5GA9zj4aC7CzUhgyPSa9YgzzyHjKT9Sc0uJQojEVyFgv6UOKUMNMEVEHmjOpR1mEdGDBAoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2onjv5z+ppb4TSpHEQ84JNNJRw87w6BmX4Xf1VoDePE=;
 b=nPy3Kx9ur0D/OM2cc3hj4rmCWwaJkcVKiKEfG8HyDbKqB4h0i5NC0e2RzXKKvrwYWIKh53Aeu2Aq4HRuiy7XvX2UhSxW/i7ZyC26PbSeTTISFPwpDdd89tvPmHScAhvAeQpeZ58Z/hZqkUeKmP/y4NFkpOVdVDyNK/lpT/1XAIoeG5bGBSO5vszRvPVfhUXBGiOKq3s54u9Bj4VdRVxVhMmGJ4UNEou/wVG4k+O5fLOEZs7sujzgdpNoVZey+U0TbCpJWimD/1rh3V2oiDmmTKxP3RWDsrbfZWYrYlhbp4EE1JHaljyr9gQ77KpY2OkldOhVqFD6pIDE0idADac/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2onjv5z+ppb4TSpHEQ84JNNJRw87w6BmX4Xf1VoDePE=;
 b=Q0OiOP9sX773IXc4/WjeOfq4W4kHGhMVn1z7A2A0u9ZEZ0sEwPa1OaqdflaFCWqH5TBiGAd3D+LLdpnSffdJClOnY4CpgKI9Rv1IuQtw+UPmlNhiZ+9zzwIo+03Xe01cKxPjAZkPuGajcukRMXDxP3E/dzua46QStOedlvb6akA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CYYPR10MB7674.namprd10.prod.outlook.com (2603:10b6:930:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 16:21:29 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 16:21:29 +0000
Date: Fri, 16 Jan 2026 16:21:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND 1/3] locking: add rwsem_is_write_locked(), update
 non-lockdep asserts
Message-ID: <5ca7b2a2-1e9d-4d90-8459-1aa35b30b49c@lucifer.local>
References: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
 <8e343ccb9319433364f5949a69519f1bb521fc8a.1768569863.git.lorenzo.stoakes@oracle.com>
 <20260116151215.GH831050@noisy.programming.kicks-ass.net>
 <99818e30-9f88-4751-af82-0bed019156eb@lucifer.local>
 <20260116155743.AuMKcTAO@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116155743.AuMKcTAO@linutronix.de>
X-ClientProxiedBy: LO4P123CA0523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CYYPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3c5c8b-9ca1-41eb-2a91-08de551b4db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qEa8mxevyeA+hBH5ZMFeOeQ4MaOBsKsvyYBGhp5fhw6jfpvzrnpzfBRw9Z0N?=
 =?us-ascii?Q?h02Jmk57rgnaJWHrJXbVLQHeu+gg2ae+lOuNjuwr9yv6n49EGajXTGRnsCvK?=
 =?us-ascii?Q?zk93U64Hf2hUM58pkTl+5xG3nr+sgLF2r2SM8t+RbxuN5NHutFua2OE+NExG?=
 =?us-ascii?Q?OVecCNb4iSa9di40FtAUj9dPBQPf5Zu66V6DYhVHdQgcnzDr7VBrtVVNxSQB?=
 =?us-ascii?Q?F6ursnyRhcOCLt1R2YOyk8ib9pxhcaRZl00zbcOQjwvOzpYNMGW8nkj+Wt6r?=
 =?us-ascii?Q?D/F5M3luOdwOCluNcjq1uJc71199kWjx4wgk7Er88KsxR7lsjqOxsurLkN8N?=
 =?us-ascii?Q?23DrWMqe9pLc/yx1yWKdRpI90N3MeTuUB+G9AYSLnKM4FutDWkdECSbnjfbL?=
 =?us-ascii?Q?uqOTUBGxea5OveT/hyCH0m1GFIJAgXNTC/tZVs/Yfx+cEteI9i8phShzoRnY?=
 =?us-ascii?Q?Nv0OAe2Bx1AuBOnSeGIiVb1JWjE32ES4llyCzkmebbyMf5UBB0ESFKs4MqVD?=
 =?us-ascii?Q?SF1lWYGM1MnwHKMTHgy5kKHM49iFcukDCVWfQe3Grk6yoWab13aU1l+qLpAS?=
 =?us-ascii?Q?McFOXIn3VSl4zxfPfXqkiLrPY1ygYFoBCpzFwYuqTda/vOyFyS7+yLmv1Ed0?=
 =?us-ascii?Q?TN20eTWAV2Olp7JiKNG0JK3snGEBLAWxZIOYxdAbqnjLsK25jPaHj2CphhsA?=
 =?us-ascii?Q?RfWma/u4uE0Ql9+HJp8S9nf9Jv4K31bp3bhip6Zzdx0A9lt5Qs/RxdGcyHLi?=
 =?us-ascii?Q?YNsCPOB+U7Uf7+GM833LV0VRd4DgswPGcvAAJp6dpAC8x+sqLUur7cblZp/T?=
 =?us-ascii?Q?QG0M8Isng+jTkKk7SOw44WV4GT6xP+/weXBym9J2mFrXuNcvq0YA+BkIAW4O?=
 =?us-ascii?Q?VsUDXms/HIvCieTDOORW+T5RTiXHMmc7A2E4VvRPJZ4+PcSiDhswJSkvf3iQ?=
 =?us-ascii?Q?7WOT8wc+a9iu4g/qSHcpSk7N18IVbpHXL/Rumy6PO50YJ4KE41eEoYu2CrhI?=
 =?us-ascii?Q?jWmiMQnxF+K+fhyMZ3Zc53ucemkCXHp2jPzNlykpMXsRce1fl5PEwgDsW0UA?=
 =?us-ascii?Q?hrO5GqEXlKdia1UrVifReOxWaexcroX7G1z99krEJSCeTJHSAr6IvSqiyLjf?=
 =?us-ascii?Q?xZ8dNsHaDoEx6d4BbGxTgmANj0eYh18R+q73UXW0NRsdl/2oJNmJdlZRF9tZ?=
 =?us-ascii?Q?RI+6H9huChetMlmWM4boPbN+N7bgTX44rMnxYIUsyZJ9XbkU/oeNvxxhqPc/?=
 =?us-ascii?Q?8z0Zrn2OaZGef25AhpKL7wFgFmujzqe+gZag4QQSyqcqT/Kj0cgw8Jk1iEeg?=
 =?us-ascii?Q?uoxCraiRKrTwdh4fU5EKXwqD8KnAVb7SolQ+DAHodbnQGncZCgFt39VFy1+N?=
 =?us-ascii?Q?9YDBlgkn0sdbBfk9Y4xU1h1T/an/kQEm7t3Mj/fdSffTuA8u5APGtb4gB0PC?=
 =?us-ascii?Q?8feIdY/6jbFRdGwagNxegohZKk0cwPk8CuPuwL6xbnFsVfcmsvyNNg4ECM+0?=
 =?us-ascii?Q?Ps9scImqMkD7ohwNwG8jjJMnzmvZNkOMGPoET84U9sIDxQn+BWIwZxxALZo4?=
 =?us-ascii?Q?VWp+y1bM+LAKlYuw54E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBm/8nlqK6iSiwjaYkr/1/+UBDJinbmKrq5eYE6lFUOL5E9hLFXuRVyBGfQw?=
 =?us-ascii?Q?gU2uM4s+wktHunaIBcoXkpDRMY8b+np9hoQZHXJ6T18ipytsGtZh8QB7V1kS?=
 =?us-ascii?Q?kXcoOAM6UiSZE5E+6WIUlexncpXX3BOMzkUVJGS22BnKlU/vHr2kFLBC1Mvt?=
 =?us-ascii?Q?CPWiuHjCZnJW6AXYCOwBrdsDZ9tMCG2aPjGF9RGGlF4UVMFruGwAAhJCMo2/?=
 =?us-ascii?Q?izMWYfCvRo8diFpHJBJXhL/fFwaeHqSAy2y9+dMK5SdMwvZAzKDWoe9RVgLn?=
 =?us-ascii?Q?TRmB7SuJNwBVA6tjwLf2vOI5hgBKb4gS2YjVB+JZD2bTPWlNSw5n59gplNhH?=
 =?us-ascii?Q?sBotyQLZMU9FOUlH/u4XbKXm5JxBQluo/EC6qXvVJ1A5D7KIVN1kD/yPan76?=
 =?us-ascii?Q?ItNMqTUlum4JpTQFKC76DY0yKUjESKQ4YdJVFqlcjsj/Zmo4lCgzcxBdz+oH?=
 =?us-ascii?Q?E+rAP3nbwkwRLaeVANQa+fSCOEN+Em+ant1N12HrCVmJRSEdRxItugPRgXRd?=
 =?us-ascii?Q?mT0kAPttqkW/pq4USYPd2Z+DdGonTYkBQBw4w2PP1tzsuzpHEUcfVk6xIjeq?=
 =?us-ascii?Q?JxFVy8yW8Z5800DAlZKzlsEpg6JFJqf60XXIrhCcvmIq9C4noxP2f11RfTx0?=
 =?us-ascii?Q?vlZRseFK+Ol/oOCJO43gz1SBV2ZVsYLG9mGOIgyT4B2FiUTICewD/ietw+Oc?=
 =?us-ascii?Q?uvVP4ZypPelHzQV43RxYJa0V68liLQETQsQRI3vNLYXzBEu/e5jpoRY0z3QB?=
 =?us-ascii?Q?yaDb31TXVrTymc6I9q4F667iAMqkgodyg5fm94R0YpdjKrl3jqO2O9DV/9Vv?=
 =?us-ascii?Q?1dxyqa4ofDH+x4yn7+q6o7Aqp3Uq6fBbrTvfiBWEfq0COa3JaBbpeyJb7oeK?=
 =?us-ascii?Q?Wh/zFL9E9ejgpI+C9x4kntDKUy2Q3yCrmuv1jEfOiRHWtSVZB3F2TUMJekud?=
 =?us-ascii?Q?GcWJ0O4jSjsAN+JNu3e7NA7XlhwKfxuHYGTrerr4PwAwsZmSY+RD08FBJBxM?=
 =?us-ascii?Q?mOWx9nDQmleLtZ4JVm8Ek2Ye1F8+esYWzxRtDsqeJel4LeDa/k7KsLe8SGO3?=
 =?us-ascii?Q?Nyi342+jLtOKxikFT3rtRtbgMSTWk5cBEd12Vr1NYm0L8mvW67lki9l1Rnyy?=
 =?us-ascii?Q?WLY2RlcetgvTdoh+EkDGpQSAhGc1N8MgKIIut0qqZ76jI6eCBC9+2I9J4T4b?=
 =?us-ascii?Q?bGWk5hDACx8Ozs+mm2b6+sMjmaA/F1qd7+F6yjOQEPb8s1AlXgghmVVbuyMt?=
 =?us-ascii?Q?i6ihTIXEozXJmxifTxcPdO3wBDqLsYZjXT/HclC0H7lPIE5KSnSRRSlpnJkV?=
 =?us-ascii?Q?XMq1+IGR3J67lB2mgxAxHsDiPa8EHj2mkh2bSVWoQVe+npIj/LWxv8b2iPA6?=
 =?us-ascii?Q?FwqlqHkKtWLCfjfNAdjAhcJeqcSHMEFFF15etUX1rGAHvo+FjHsCaygXZqUv?=
 =?us-ascii?Q?sFLmzLtI5L5IC36refQ2YuVcjdS/POY2ZPtUPx2s+5jMROagxVKNvApWUmuM?=
 =?us-ascii?Q?NVO7JXm6Oqr+dZAzfs0b9znxRyeBDZA3HB1UhXAUo8cOq8tkqNvO5eSyjdBa?=
 =?us-ascii?Q?EZnYLg8ANaY3D/NUfrTbgEleriaxQzJkj8p6CwK/Oa+xq8JobnVGh8Ld79wJ?=
 =?us-ascii?Q?Uzt2BnTCtT0o1dIsVoDctrBRR91w3C/WPTDAbgfk/6kHHwcJE0PdHePvC24C?=
 =?us-ascii?Q?pWuVCf+t7+hBRVILoeI7Z2x7kQbu4XDtNWoiGj8ZgmUJhEyThltKQTPzkKAD?=
 =?us-ascii?Q?MXHlVQBmfM6YUxMrVVWWVIsWaY96bVs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DRQRr+6tHuPl/QCPJHVmTLRZEwO7sMpmcfeVr+8Yg0qrWi1sRhWsjB7fpOUbIS04X2CuRTBAxysD/Ed6EulX/94iPck/9ODRQarWLnqDKhoUoorCwjCeZRwlr1AshFnOjoy4Dg7auDiTqhdmbdKxUV4vbCHBz4Gkiu9sc1BhJYRL4kJaJ3qpMhH/33Sv2GlXnPyaDq2UQsuVIkTwQki08Zv4Vg//DtM/PsFF7WxOAL5+f7tJb9l+KIz4yi+0X0j8/Aq1kvsGrV21wWJbCqyxtG/KMrfC496VLsjR4nh1udjoQSxrmp2rPXp7Ow2FeLtDoBOCnGg6RJ6MOEOJg2HFT59KtAKeXe+lA/pWXZoI4/ahLYd2Lz228HAMpwQqYtLM8wHrbV48luAdH5L+OEe9w9hBbUSDz9zbbWdMHRRrSYZxrBrOcGTWDsZa7C0R/BNrytM5/iCc2JLh9KzgsDRFkzNfEBjMJT2jFr7uRaJgWhK0VqS+8tWuGQgfIMjQ0tg5WIvEmK3A/aABscPYVal/T2yP2aaPBvUW0hbsTxw0PpVI5x+RYXWlhZOecf+M9Y4rzNy2hlSygDtCGvA6Ol2x7lljcv0eqQafI7OcqSr3Y2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3c5c8b-9ca1-41eb-2a91-08de551b4db5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:21:29.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5a+q18tK9vpZwq+HPDqTB8AW2MtGqQVBRWZFd7Gq6zFbNZTFlTiTBNf0PDQ1d98jQJRKZtlDO1AipATdXB55Z/MHhRMNs5hMmQo5mSOGkJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDExOCBTYWx0ZWRfX3FgJtdAxOu45
 yL774fdhXZ+ZkeFKnuBpaTBV/BondazSJE5WS809PXGlEZGTnCEEkGJL7lUwX1U58dnQH5vKJmQ
 i0h4UOQmOvWkqX1/QaobDC/y1d/17AHonnykMXUfJJQI0JU8Xs0w4vSgViaMaiXjbiHKysXHFTW
 1ojbhMS2makDElEBfICM7Mbj2uyhXd8Gs8n/MumPSIgL9nDYfqweRBgcBRzipxMHveVQdLz3Fu4
 G+eY+hKqZ8RbrYs8WiUHCyq75iPnnrEmrE/XAZGTtHJcGF0CTNJI4uWCMq80aMra+IDej+maWmT
 6nvpq3dimScV1ChEzzGW1OCvMYZlgdey83BkdQ4GL3fhGoRaSx87z8zUMsbODk6llVYuGQl32L2
 r+S3rbFh5DFq/u/7hLglOfotnu9PKu2iSgv2JW7lsK0CjENUKcLdfCUbllrXwO/Am09PlSMnMFB
 CqtGlm6nAAkuBFpHjnA==
X-Proofpoint-GUID: emMUQkpH_1aKTZbxGlri0dO3fRFJ-PXQ
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=696a658f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sjHe5Sqy4sYmgIh6ds8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: emMUQkpH_1aKTZbxGlri0dO3fRFJ-PXQ

On Fri, Jan 16, 2026 at 04:57:43PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-16 15:50:24 [+0000], Lorenzo Stoakes wrote:
> > No, but we need to be able to assert that one of two locks are held and we
> > don't want the failure of one being held to cause an assert when the other
> > isn't.
>
> But why don't you use the lockdep based check? That assert only ensures

Not sure what you mean, the checks I'm adding don't exist yet.

> that it is locked at the time you did the check. This does not mean you
> are owner - it could be owned by another task which is unrelated to your
> cause.

Yup I'm aware that lockdep tests more than a simple assert.

I wasn't aware this was possible with the lockdep primitives, mea culpa.

Also this came out of a previous discussion where I added a similar
predicate vma_is_detached() and Suren suggested similar for the locks.

Anyway, I went and looked and yes I see there's lockdep_is_held() for
instance.

However, I'd STILL need to do what I'm doing here to account for
CONFIG_DEBUG_VM && !CONFIG_LOCKDEP configurations right?

So I'll respin later with if (IS_ENABLED(CONFIG_LOCKDEP)) ...
And sprinkle with some lockdep_is_held() and see how that works.

I mean rwsem_is_locked() is already specified, so naming is going to be a
thing now but I guess:

static inline bool rwsem_is_locked_nolockdep(const struct rw_semaphore *sem)
{
	return rw_base_is_locked(&sem->rwbase);
}

static inline bool rwsem_is_locked(const struct rw_semaphore *sem)
{
	if (IS_ENABLED(CONFIG_LOCKDEP))
		return lockdep_is_held(sem);

	return rwsem_is_locked_nolockdep(sem);
}

And obviously equivalent for the write case is what's necessary now right?

Or am I misunderstanding you?

>
> Sebastian

Thanks, Lorenzo
