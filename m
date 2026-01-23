Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3128D8D0
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185725; cv=fail; b=VwuZclY7owi2U8htbITOcWBktESyWhZ14shF2ZAq8iyaBN5ajA1aTpkDdN3lzaxQDhc8sDRXZLXbiA4SvbOA/QQpdqscmm03T6DITAIv2lwkordOpscPp75YZf56KkejxLkSWt3khUZ9ZI1qhKEvm0vWXDvoD1cf/PJJnxoi5XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185725; c=relaxed/simple;
	bh=Y41xxQlUBKLqvQHraThElS/cJhC5Sd1HInD6USlMKLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T7vsdS72GhHt9nsb7c4cUNfbVjkfdTgJVJam2jxQ8PSAbLB3KNY3XXtX0v0utbTn5pCGp3YAM/SWANAFoiQIo4GB2WJb0ErMmi9YQy8HPWIEo4euFUnRAKqNmF7XI/4r12un0yxKP4aF4/JqLmmHsgnOFKtUOk1v+CqbLBrOn9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=opKGs1kk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UqrURtAC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="opKGs1kk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UqrURtAC"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NFJNIv2270793;
	Fri, 23 Jan 2026 16:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Y41xxQlUBKLqvQHraT
	hElS/cJhC5Sd1HInD6USlMKLQ=; b=opKGs1kkehLCOzQI3NyWXMBKCWvXiB+jjV
	YQvHpj2W8ZxxpgEr7unGvA4t3jRksa6WYIAB4NvF3qhItL3Ow3NiFOheApz+ISMH
	JmbXUVrq2rnkR7eqeqitvFkkVNiOrKQS/PysxInNt7+s/QFujDamG+vvWZlQEq2q
	SxQZCa0Pv0TdEbIGN/D2EdImLxjMwSZVjrU+QlIGC9A83nakdZ/QWSsFHOZ8bICF
	RwBU7BMfMCjj2BxQqg2N45T4KtR4iO0qxADJ4ahv4EY3u7sFvBPQhL0hyAtKOuoO
	WRJZkWLhtrzm1smlAPFSiS6nDl1lc9fWwglgjZ9H8uU0y0ykAbBw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br0u9tsn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 16:28:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NGBUxK022439;
	Fri, 23 Jan 2026 16:28:23 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vjb2ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 16:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5NEEUJDNXQzPv5fODj1PK853DmuWeeCcP3a1CjDeS8GdqNKmXgTaimnbMYKr5njW1tDlkaLa/4i2RgzhyKOhWyU3bY7DmdBBbH65y2y1Ez8pI+Wt9nP3S7cCL9RT82m+tyXlof3mi+GUbZ0g1FfewWr/Q0Uct8auQ6+o2IRpB9KgYix7C98mM2tpAdWOu1Zbca8gqvyWF4YHAMfooZAuTVMWMgpxZFhkHOeTzMY8nsPEQokKgGBwK2b0M++CM4Kk2EkQ2oOp+cyXIU46Tzv5tC9Zw6bGIsaFrxTBRVwtfeWNg6YGJfgfMlR8WX7RFBKSTa1MhGfY29IQXw0OFV2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y41xxQlUBKLqvQHraThElS/cJhC5Sd1HInD6USlMKLQ=;
 b=XQbIWfSwGfl6Ah/lVULteOajNeDddboNbrui2QcnJr9X0EuEfZ/Sf4pDV74j8kn+ChAiaa980s9OTquWyXfdLS4MCMgm4AiTbITH3dFaDVxbGC9Zgv9e3tLMWRVuMjXE3Zk4GmDicIMME6n8AF3Abs1hJDyDuLeLLEz9xq15gMG9Yt2orxd/+4K+IhCCWpUweiASHEINnT+18zzEAY/LOdPfc/bnwnboJY5BZ+QlTooG/o1EDTIIvXMx8tg50vLtv0rr16VZAgqZDMwypNEWfi+m6S4ibKQ1Ha1+8ig6o3O80ziRg/8SOB29/YAh4wZIMG4hr4bJG/jRcYTDLDCsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y41xxQlUBKLqvQHraThElS/cJhC5Sd1HInD6USlMKLQ=;
 b=UqrURtACyuffbEllyhGDFtTEF//4y1/yX3LP6+pEi1cpUmlVOl4N348/v1DI2uOX902Qhh4Rs7zl5U+uDtjDXU5tnBzW6OWQKBQGXKVG2ZdsxDWwK99bkhRDM6qc/OQIyQbRC2GDu6CY1TimdTfebC4zO4iOU8nzX0gmMlabo9U=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 16:28:19 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 16:28:19 +0000
Date: Fri, 23 Jan 2026 16:28:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 06/10] mm/vma: clean up __vma_enter/exit_locked()
Message-ID: <89fbbcf3-25b9-40bc-9424-f8fa89b1c03f@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <f1981963e3c9421b6ffef19f15d87953895cd0b5.1769086312.git.lorenzo.stoakes@oracle.com>
 <0567268d-edea-4229-8bf4-bfbfc2af1fd4@suse.cz>
 <deb0271a-af67-4971-8e2a-be0f826aee2f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb0271a-af67-4971-8e2a-be0f826aee2f@lucifer.local>
X-ClientProxiedBy: LO4P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH0PR10MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 303c8e77-6aa0-483d-cfa6-08de5a9c6b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJ1OoSjsI/bnqtkTl+ZRLVHZMdCqcDKjICguotnOldTU5LULMJLo604v0AqO?=
 =?us-ascii?Q?MwgqsxLHhwHli82FCWk8JTbfR08ayvZVwJp+XGLo4pn0IFbVKAgI9lBY30zd?=
 =?us-ascii?Q?R3FW7IHVqlpYy42B42ic5VZmDy1jX3nY411A10H6LOe92Y+t7DPVomDSJh2Z?=
 =?us-ascii?Q?SJ2KPauJ/Ijp7+EpZi+2AlTVrJzZxQVltW3+UUR6dua324xmcEX/tQe3OBlt?=
 =?us-ascii?Q?Oc5SoI7z7f3odBBkhvQVnYab7OfErKZ3j82sG4hQs98BtNFKf/pgudp8pE5g?=
 =?us-ascii?Q?RxSLBR99iOArzHJC6pt1g6JDyCpQmV5kphDhWrZMtnZt12icWySEWOW+O+Ne?=
 =?us-ascii?Q?wsX3NBz3ogFRg6W+CyYERi8Lwi6+07LLjDTccB5YWf3N3xAB9DsU02Ll+Hxz?=
 =?us-ascii?Q?q32ZZn8C9Snz2o5U2bFEaR5n0a6/1+OUpuJyNWpJQMCoClDGikOq0UDq2fpz?=
 =?us-ascii?Q?yrjB+gyYOwvrw4x+cf+opTiXnzIBgP2l+F+HtpQvAHiRJbp22zNttIeEGzhr?=
 =?us-ascii?Q?Nqvr94pRFovbxIBLCsMEUw9qzUZlUp7xt3xqT12RKD2K8iNry3MxbGV9Q5WX?=
 =?us-ascii?Q?1hWMbDJ9atJWsSsiw1anInV6IrxmahY5fuhTXLsDVAdJD1U0byaCpjOYRYZ0?=
 =?us-ascii?Q?8c2DsI2P8gnDBaXLpu/4gYHsEuZ2HDbdnufoCVCZUxqfVLUJjrPn/BILSAZr?=
 =?us-ascii?Q?nrV4xancbwuQsTk/9KtwcARTQBgCgRnW4SaDeHLi+o8b1IYOoGzQGJ4TXlCU?=
 =?us-ascii?Q?NuKeSil5lDnC9M6KuhCvzTFyAFRPO7Ip5bQgnbPT2JDxLRFhC5L1M75vLyC8?=
 =?us-ascii?Q?y6YAIhxUuZuXTjOcERKbBnpZ2Nz3niA0YTvoFMzcjgssvhR5jHUc06rQFFXK?=
 =?us-ascii?Q?+CHYEjPGOvjVf7tT0Zr8mphQCRKG/HlM5+LaKPCaBoRIh2yNrFdni5ih9S+B?=
 =?us-ascii?Q?ud2J7tyuyVIRRVh9uF72UGe4q0FSVLCvR3yIRfYPqqj8npINmf+LS6ZIWx4W?=
 =?us-ascii?Q?PCPx7l/OP/DrN7jYfZ77H7vPKLGOWKb4RgSNi3XTfQBKO66p9WX0NnYhmDHX?=
 =?us-ascii?Q?GlHoU6YuXjEVTsCMSsaiQB7VF58YKuEKb5GmdpW56oQJuVX8BL7ad/PCMM2a?=
 =?us-ascii?Q?POZB5Lay+DL52SBGuN7RGGhWg/fEUUt36swFL6NXGzNfQucYSkvANyRMWqA7?=
 =?us-ascii?Q?dfdvGC7DCZIMs5++1Q68trHPNm+ulUavq/+L/GoPDNH9EpEV7zHdEo8U16Jl?=
 =?us-ascii?Q?WOdKANqY6p5g+tUszaiy0svsi0zuk4kfHmW7sUjj+9NHwYngkIbCG86ro5uB?=
 =?us-ascii?Q?SLzzs5dviQ5Qb+mqVjm0EdCJ+WENfxFrUaSpkH5j88pa/FbSwA/E1EVajK+7?=
 =?us-ascii?Q?z6HpTHaJjRokvKl4B9nVcvimEY80LK3RcQyp0JekJbEGM+mVKg3JK1t0/LFs?=
 =?us-ascii?Q?88dH8j51++8hWDZFZj2CMv3Hp/5gNFJwDmSU3bmFBt20x+X8Z6GpB8QUc3gG?=
 =?us-ascii?Q?G9XX6tCIzsIW0vPtji0sS18A1aD9dfljgzLn1t9u895qe484T+Ali9ggP1dg?=
 =?us-ascii?Q?jPWNItOUp3UokrE+9fk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2hihzIpSgR6p3uyaW2W69eybawqOpLcspAw/kIIf7WXptsf5IHwcJ620LfsD?=
 =?us-ascii?Q?HCG1A40f6jfERKuEU+E0KBjZlg3ZdSKxpOhW6r+gaEUQMcMb9GPD8YiA4RWH?=
 =?us-ascii?Q?T31voXDe9silYpsHfXo7095kKRKvT/cxF5uqCQFuBT4FjV4acI1iv6jQn/+S?=
 =?us-ascii?Q?UtvxojIRXoIYczT1TneKVP/u/F/JiwK+1lhcBS1CyDHdU5spTdEV03EDXLbJ?=
 =?us-ascii?Q?gG1sQ0kHZjaGYp4CjEYtrYHSI+eQHHsgZ3XyiNjIE2lWpaSK1yRvgpc7HYSk?=
 =?us-ascii?Q?+9fmNFnBpFpqhQd8Y3Cq65+FjcKWQfzDhe166sonuEF5EeTRry5p6gqYtDtO?=
 =?us-ascii?Q?wh2v6yXHzjnkjhADEidFEKYTQJB2RPoqdJbkifQ8P12nae4JwZXemeXzX4z7?=
 =?us-ascii?Q?HIHzGHliz+5cNY0Z/LGU089CpcoS/GQ9t9RrQ6VRMi7ivL7ywPWRnY6DVssR?=
 =?us-ascii?Q?NIsnG141qKoUmMRgFwDUh4b6+GIJdvgDWWqfEaVz4Z9u53PZZVgElEkyhG/5?=
 =?us-ascii?Q?ZcsjOTljl9jEMP4R0PTxZXs8xn84tzlC8ojDnYuWCrgkCnW8L+rtIPx9n0lN?=
 =?us-ascii?Q?IepdCvhaigt2Cuhtl0T4JFNtiOjT2GA9xs+4vMFtf14VMLfNY3UwicZhhMHc?=
 =?us-ascii?Q?ak3bv5WODFGZmojlzm1hg5kB/Cps5a0UOCSIXQyRSC9PnuI2wIQ+N+IEuOZE?=
 =?us-ascii?Q?7oQFeAspFlpOmdnOrlEHl3zCxa3wwvZfj6p793BcCEB0ctrPyZuQJFCs4Ca7?=
 =?us-ascii?Q?A3yM3DVwWsH+Wu108Lc0C8NaWlVrP2a/Ep9XbSMVKpJrz4bnjJ0IFnKB6LNt?=
 =?us-ascii?Q?5Cd+ot34HHYKanICUZoWOegHApeBVrK5jjgAo486p92g90tjAL1f7YtEfqYG?=
 =?us-ascii?Q?iEDpH7RpXDKdy3lGFwQpwPQThfnGYtyA9G3tAyUnu+VuSNI1JWuKEHDwBgKr?=
 =?us-ascii?Q?+kDCetKC4tLuYU3QvwlbQZArNlBMxTroR2fmmuFic1ArFaEm/lxUn/7aCKlp?=
 =?us-ascii?Q?sHYzbUWuBAVxVqZilIPaF2P2rciSSQJWye5x1n8Wlrlj3ZQYaXtP426JEnMK?=
 =?us-ascii?Q?B/NLaoVoGhOp3Q5sljmVRq1FMMgLUuZG1TEBmcqrrzXVCg4+tqe3WDLbWOnZ?=
 =?us-ascii?Q?KAcjkVOR3UUiEDs8JQOAmSZgAijfWFyX0MATTtaw2kZvnZ/d1+EnVRhEBMZD?=
 =?us-ascii?Q?mMNkKaKKsqAbhiN7Mo9UIcOoE752ZgkF6ORQ/ki0PNSok/kzrFP2NYqmLf5U?=
 =?us-ascii?Q?nux7LEkUfgbLPppK5ooLYwr+04+hkIH9Z0we0RrCyYlOq/drC73/4JNr3byz?=
 =?us-ascii?Q?oxJM9PjV8ctZF3mgmfMVfwmKJQBdShHSXC+nQweWDlkJI5bRKqTzfBQzRPkM?=
 =?us-ascii?Q?m/Q38uWhlPZGa/WvJJe+EsmCDk5gjvGY/rL5zpmzdbrvbuh3YWfpZyY1YapS?=
 =?us-ascii?Q?PreTINZeb910PhukIyKpyE10B960yAX3Qumxj9kXp0rHjDOvJ7ymqThr6W3J?=
 =?us-ascii?Q?25KWR4avzR239flJlP5HDbFLE5nuO/PVjwwpE8ujJ7Wn8JF3Av5wuLfJ8jPm?=
 =?us-ascii?Q?ycUHKs1pv6H+Qk9lqH6DXwImERg2mqGJtiwf4zmbjed/jXw55nzHY/LGqj4W?=
 =?us-ascii?Q?ugPLvJrDTiyTqFmoOMoY4TSxkkzjjCu02jaM1tLeN4JQijP4pTHtwig7bikL?=
 =?us-ascii?Q?7PyHBmwLBfCr1uC+SSBVjN4Ftpcrmx9jmBt/3rCJhqoi2nCki6zoZftIDrbT?=
 =?us-ascii?Q?gnV3aU7lEn4bGkCBdM+SIOAhSpA7HDE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	67qtzxPtRW4uATOOeHI9A2pZJlQp98j4AMjpy9bnf5/jnIiNVtdESwnibaRWugU3WvmzKdqWbuaHm/b8jVY7e7N0h4UeZA5li8pw9c+VSibxiBAb0mD6Ggps9xfG+Udd9C5AmSuPxZs3BtOZfcocLHI7lB7KrUs6XlxL7vJkdNDyP+iIsRybnSFV9EJ6bxhTJ8ztKQzntoLjm2OMp7cTArQYG7mB4ZsbTooEeBIL/TOXo3B3lr/axB3m0waeS2+SSM5Y0Tk3JMhrYekgk9sT21HgZMQLDzybki4FFOXrRZg5ssZ5sHjeDV0ZOS9DHNha1/e8z10PXd/fqOOvtMUXZap7ii9rEIAT13dbkqIFPjmiTIGNNiEM8MWNP7bl7+lZq2EItq7YbHeveRpij5HrEbpfuBfVCQuCKfMrrudJN1F2HmHVt/ZzqvEgrUnes57b9FSs9TEkS+bNoT2W1emNfY8NQ33YSq0KzwL018Ka2J9rvNUpB5vg4MwgJceJv5WHprnK70SqsoRtRa67hI2LoQpb72OdRu5Ro2BYTqDpHIzdgLwvkJM7auV+brfG2JsCcMMoV737wQKyEei8gxJl0FnFmjxILrvIS4+kJRObfLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303c8e77-6aa0-483d-cfa6-08de5a9c6b74
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 16:28:19.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SuBspWapEhzftlLlmrMxsYGTJWvdRMpPl/jSwWmgvzowqRo4kwRwuwG+HAlfK3oyzH1olwluOqLxrkEAyd+zUaj8cVUWD/Gh186wvjnNEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230123
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=6973a1a7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vWSWekDQ5-h1ZfxgX1gA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12103
X-Proofpoint-GUID: xGwOvlCWG31uzrPOnAUWNWgvftzURpeN
X-Proofpoint-ORIG-GUID: xGwOvlCWG31uzrPOnAUWNWgvftzURpeN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEyMyBTYWx0ZWRfXwsSPp2TuqCme
 H1wknYEnjONCul6i2z5E5D6Q4Kmt1Kkfz5Zlb4r7Ueofa8Qxa/laFwTRVzvSC91ZEOQI5JGh/9R
 wJNBVVqSjY84nUc9p6bNvfr/9r4CogNiUvjdBSh7LSW7fiN3/ZB1at5ZSl4ju09RFjLqU5NH2yy
 NqhKkaPuGQ7MTuZThEMHyNhhFIwGL/XqMkFt4KPu7XfbxwVH6j+1cpE5zcB/XcV5Atol+rxEDQg
 hVRJqC58csocztQL9UPIK1V1f00xGPzsX329Zlbg4T3UWOl3csZ8erreijFDBFxZA6Ivsg7cxF7
 L36ZL05ZuXlqgXGzIYGTTH7yTug2zD80UoP3wXlk9a3ntbqp11V7Qz8RzpsUuadXggNvCf1PO9V
 LKGiES74Lb9rzWbYMmV8wdfWp+MQOC0CNIOvXOWkMEk+XWtrHAOGLiAafofRFPJC73j8eMlYKVb
 LBMtYtvisPPZu5Rr4FFi7cSF0RMoV8TueYpFtlv0=

On Fri, Jan 23, 2026 at 04:17:54PM +0000, Lorenzo Stoakes wrote:
> On Fri, Jan 23, 2026 at 10:16:22AM +0100, Vlastimil Babka wrote:
> > On 1/22/26 14:01, Lorenzo Stoakes wrote:
> > > These functions are very confusing indeed. 'Entering' a lock could be
> > > interpreted as acquiring it, but this is not what these functions are
> > > interacting with.
> > >
> > > Equally they don't indicate at all what kind of lock we are 'entering' or
> > > 'exiting'. Finally they are misleading as we invoke these functions when we
> > > already hold a write lock to detach a VMA.
> > >
> > > These functions are explicitly simply 'entering' and 'exiting' a state in
> > > which we hold the EXCLUSIVE lock in order that we can either mark the VMA
> > > as being write-locked, or mark the VMA detached.
> >
> > If we hold a write lock (i.e. in vma_mark_detached()), that normally means
> > it's also exclusive?
> > And if we talk about the state between __vma_enter_exclusive_locked and
> > __vma_exit_exclusive_locked() as "holding an EXCLUSIVE lock", it's not
> > exactly the same lock as what we call "VMA write lock" right, so what lock
> > is it?
>
> Well it's not exclusive because spurious reader refcount increments are
> possible (unless already detached of course...)
>
> We are _excluding_ readers, including spurious ones realyl.
>
> >
> > Maybe it would help if we stopped calling this internal thing a "lock"?
> > Except we use it for lockdep's lock_acquire_exclusive(). Sigh, sorry I don't
> > have any great suggestion.
> >
> > Maybe call those functions __vma_exclude_readers_start() and
> > __vma_exclude_readers_end() instead, or something?
>
> Yeah that's probably better actually, will rename accordingly.

Actually went with __vma_start_exclude_readers() and
__vma_end_exclude_readers() as felt they read better.

Cheers, Lorenzo
