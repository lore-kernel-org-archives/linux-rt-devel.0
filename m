Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299541EEA5F
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194275; cv=fail; b=VU5EMt7k4RBbbI6zHEOqDll5iDRkqonONw4eyRq8vy4PwIP7bkSNMxUnN5ycQnOssJM6UDK21Feat1+amW3wLonvJoeQFece6/K94Lwn9cSHMXNx5zEpDoomuMlwouddG2ZUE6sCtq/9ceFDibdk2ljhpHShNVqmaaj/mrfdhZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194275; c=relaxed/simple;
	bh=/yBu45EorO2DDEpM5U5Z6GQYyogLpzhumiQse6GeKA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iQKhsh73QX6x5W5YgPvjAu4YFzQnkLr95kq9wWAHvhazOeoUDgXypPfZtKhTXtlkKEydvfpXlcMLymme7ewB2WCR8lOiGRc/iWHu+LriH0QGynwlsMkIkVV4HoFU4mp4MQHpaf5xlQudHn2+XMAbknv3+g9mqBfLUDgBUs+iO/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kvwMfx9a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n/BA1bZw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kvwMfx9a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n/BA1bZw"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NF7exx2973460;
	Fri, 23 Jan 2026 18:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UT6d9EIrgPSa9lnmel
	kZW6xomQsSSRViEuYJKjA91Gk=; b=kvwMfx9aPkAv1Cv+L5tMjqjRPDXHt3HauD
	LJspUHxDznJWmNZcBNpabz5zhixK/nC4aVWIhPivn/vy/853jNmgm3L/zVfPSg+x
	3SviE4sTQTFoSvr3PHzcpzhVN350/xKIdgtp4/MhQ9505sZv8dIBqjC06mNw5HD3
	X1/SMnwVWG/kwWckLAmuueqVr14W2yn6wKqzgLlOt+OrNJq4M83+Oi64c98Iqe/D
	QsQiAReoYT/g5pHqFDaoR6y0JCSgIIdeSW/8plP5deJt8oZh26eOnBYxWrkJObhh
	zE8BguKRwHQntpBUhieuKvf5TuD4ULUbweJ7ZZo2jP8X+j6WbpqQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcyh3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 18:49:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NIDYmC024959;
	Fri, 23 Jan 2026 18:49:56 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujd1tx1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 18:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itciokrfrrmWDL9SRPBuZp7uS8ox/5poLiggZMloIIuaA7CMAEIjYQwmnBKLHualPik5GY8myHYrv663XlE6dzzAhFighpWP53DKJjH1Jy1G/djR+Fq98dkrseYBihJXh3bVEU1BQCMXGpDqx3xKotFJlF3+GHQyMmEVqUWQC4jtUgcu5Prm478V5uyHaTosrypV9ELkXXEo+dOA+ARiBXNUVy+VTtqSHlzsws9NwDEQLpxvp3hEkht6PAeND+3UZHSl0H7BSg7VGVT0AMKnT1z3rOBvhxLgICyKtAkllB8chpUhBNivNv+3sVN1yBwiEETtsxgcArwdC0hqCsjH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT6d9EIrgPSa9lnmelkZW6xomQsSSRViEuYJKjA91Gk=;
 b=v8bw/2vbZem3cbEyjKHyjWsbkaYa8jmzpDu4+RGLNlrqXNxppt5hyM/18Hs8dMRIVJb/TwOwYlktalE47R2aWIrxs3ccjmcoXhMrhhyDjh7GzwVYREBjQNjqd4R8EgQcJomECHwxvZ0K71WePkkX+yGZTCS0l2uwSOfiD6PR6t1MHeB94QXL9LcX6I0UQhdM8ExFE6aZ6c5WxxxCazjtsIjzXbZlb8qm41Ay5eXOpotNICSuSS/4WUPLtykLsuiY4q4OAsu2AozbjWe/mDOakBI6QlgaWedh25+4IE7eSGoeC6OE6ct6/7LeidNzNDsFis61CEJw3jXWebsjNL+gug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT6d9EIrgPSa9lnmelkZW6xomQsSSRViEuYJKjA91Gk=;
 b=n/BA1bZwEUF3YeIi+7UlnAMCVPZS7JP+9p3ObYFC2zaeZ5FefDo11h6TyXRVIG0TBbOHPgcx6KGImVhfb2+OrHQMz/T+6YeEioYLDH41sPr1i/Mm725QuhPu7fMQxl6JtIldbp6nZJ7hoy/mGZG0CD040uCSrQNRkF/9mknPlig=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 18:49:53 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 18:49:53 +0000
Date: Fri, 23 Jan 2026 18:49:56 +0000
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
Subject: Re: [PATCH RESEND v3 09/10] mm/vma: update vma_assert_locked() to
 use lockdep
Message-ID: <899d1fa9-ffe0-4c37-b1f4-01547c3423da@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <fbaa0ab025c1f345e559df2b1045b223663806ef.1769086312.git.lorenzo.stoakes@oracle.com>
 <1d360d08-aceb-4d0e-81ce-4544215603f6@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d360d08-aceb-4d0e-81ce-4544215603f6@suse.cz>
X-ClientProxiedBy: LO2P123CA0026.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::14)
 To BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: a8868ef3-cc6d-4b41-84c8-08de5ab031d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zmuxSD2X9SlS8hOTlocYTIEhzJAwfIqSgUyjz1+kdJ/Uyx0NjoA0BAHoKgwv?=
 =?us-ascii?Q?bgxVqe5khuxU90FzQaO1G4WUH4xVxw2fz1qWDb7Xb01uE3CPmI1xzX9sX/wG?=
 =?us-ascii?Q?oyjAE+aZkP/iUz3Z2YhnDRvH6DGD1vuSL76fTnAdBbvf6gnTjVYpyrFYi1vV?=
 =?us-ascii?Q?t8UcghFylFxnzJKYvjaNII4yc/7fuVYw2wH6ufzEMX34tssOt1KySlUmN24J?=
 =?us-ascii?Q?LVW3g729YPJYsuq3gDkVo7w/rbkCR8/4hfPEyz5xGQru4cY4K3zZgF33NISC?=
 =?us-ascii?Q?fpQeV5csqr9urZNPk1+npMcndjRg7YtnCkvod48glAToT888wbqmPD6TagAD?=
 =?us-ascii?Q?/q19aoWS94p+8D+oeiFKrd+DZ1PWiI8xOmAl5V9leLKP0WZcHBPmo67x8dJF?=
 =?us-ascii?Q?v7w6PwQC6I7UOGD3ZHLDc3L/cBSFEjqnMSdlsrs8ZQbWNJaJk1gOZP71+RHZ?=
 =?us-ascii?Q?v3kAcCjy2lzv4sqjDctribRH492BG5CaJhxowPOQj/zwKEPptByZUzL4C4/q?=
 =?us-ascii?Q?r69GFnHgV10EpbL9W6+ZAop94Yw1yOcGt0PjEs3cOZR8zRcuKQFp9buIAxw+?=
 =?us-ascii?Q?GWVhAG5072n1lfltnyA7m6Shl+lM4JAqJ2nq47hsc4bX7IkF4TEDTmN5l2Y5?=
 =?us-ascii?Q?88PrNI9ewiWQy5iN2RtPGI8lQF080eHK0vaET7DADHKV+8j1KT1Mq0gdy5Fy?=
 =?us-ascii?Q?a1SE5JEQ1Ja3s35Xn6jVSHRG8O9shssd3iosIwJMPtsTt/7T64Gc3nQoqbPj?=
 =?us-ascii?Q?1cZhUEBNdsD+Hl0ls2aDLhY+0yd1+Z1hPxhXpqRV5ElwoojTAmd9v1so2xCI?=
 =?us-ascii?Q?fPtJ5G4FA1jCcH8CXSSJaJKFP88MFNmYsi+holBWUSrercJCyb10UpJn2UAO?=
 =?us-ascii?Q?g9SpX6uQReWXdawY2+UnDWT7TXB1rkZgte4yTE+vFhPImbCdgAdw2UtphrnI?=
 =?us-ascii?Q?moTfz3XQmLgdqVA/mevRrwU9EDaafKJoh5L1M59XfEfPTanFFaBHs+TyI6U4?=
 =?us-ascii?Q?9ZfgBu9+yR+WDRM2T0wryXlpmvi2BDRbE++jGjZgrPOHZtWmpFKbn26S6cEZ?=
 =?us-ascii?Q?O6jRdOUQ1jznDfNs+qGqb37dGiQnNcupfISEJUvcadElmNSK9BU32zD/hvu2?=
 =?us-ascii?Q?GMM3XMhFApGvY3+YAHiVr3sjH40QgC2fJ/6xzRtv2MwWw39cashHg22S7z0Q?=
 =?us-ascii?Q?VAIduG1Hiv8qmyV/EKZhkvgKYpPvuGekUrt2p+F3g712tukJfPx3IkjIkvCr?=
 =?us-ascii?Q?6vsMM1DNXCtKq46gNT6AFk6Dl5r5w05Q9AQO0KXZCmcd/pOcn2gM61iZ41I6?=
 =?us-ascii?Q?UeXr9tTDdU89jayYWqfk9Rupcn9qYAM92rIwiWy3OGUbkpbE+FvPg+P+4vSh?=
 =?us-ascii?Q?QQfXU1Xyp7Bm05d6A7u3pQEWEr8gR/lvKDOzStmnnOsNzCuQI2HBmw9C1QPu?=
 =?us-ascii?Q?EFzirEW1j/uU3XRzDgrCmsrKdPqGIEtkSShbqNCb4L52AG82EECEp6g1rRkR?=
 =?us-ascii?Q?UUR4QK4bdJXgshcJzyKiSjYS4L2vY2QubGoyFEXq4bbEP84on7Sx8x5+Y34V?=
 =?us-ascii?Q?e0vQmkTEOlzm4fb3RJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xuCY/sjhl43sdX5RLW3IpWMz5hC9RJVyyvydhAeWG1+f7SL0Popp8PzGQp9d?=
 =?us-ascii?Q?IH5I7zSoxVgVpnInXjGO1fVFvAZhOgTLhQCAbImBWO/qQ2yot1t9V2BuQCiU?=
 =?us-ascii?Q?tXwWQemgbtyl+sVi37cWjqKbBSB3+5Bbl151oGZIBdI9HM/KdViVii60AZU+?=
 =?us-ascii?Q?kn5EUZFGWG9Jpkty7tiuIRTZisXSCqx2OM3SRLDvA2UTC7tFCyzx/wD7ALR8?=
 =?us-ascii?Q?uwHSdNWN911+EylJCUd+IYw2IESqvMkmc/BbBgaJd0ANtNR2R5UleGHXmNWn?=
 =?us-ascii?Q?MgnH1g0X5210cKJcFvT0ZH4XYJJo8CDJ0eYpaLYCeVlKClgDThTjrpGs1/cD?=
 =?us-ascii?Q?6jXcJSZrp284MtCGnhGkY2ddABac5i0q9J1zI4dNBbwq5toevKmYXCP7IkKc?=
 =?us-ascii?Q?uTK38blCbXVgn75Jgp1QqmxaFiH/0ZYRlzJozwVZtYfIWyA24ZnH/wd/XfP7?=
 =?us-ascii?Q?wP66G/avkTLrO9eIoa74UsqReOnLoH3jh6k868vSFaEBfLqPoHqxCcE9OPtm?=
 =?us-ascii?Q?HB+SHgCJhtE94op9dvrzwhlt9/E9ZIJueYc4uF48cpTC7/u45u7/FJkVgvPH?=
 =?us-ascii?Q?ZVgu7txbrB4gHTPHhluGJVZlPhm+sSIwawFnOIXjwojiYKvlEZVXW5PSWI2w?=
 =?us-ascii?Q?PC+GbLC8/TCa+uvvZiJE9z7Rn+cEOGm6RkIQ9OD4gOGbi5sjiv3njSRlYMoB?=
 =?us-ascii?Q?5DzWfBAfI0UDYMRXvRkOyukC6GXzuKp60OwJ/uvQQhb8PAHfkMR2bQZ5QZ7/?=
 =?us-ascii?Q?169o1TKbaRYjtnKGFMncdFq+TKCM3JoMDrI5i5+J/GP/S7R2WMkkg187AMgC?=
 =?us-ascii?Q?qYmWyYNadl/vTQSvLCXasIF0D8bX8HrnZvDcUxhuA7wxu0GFSwmZQEpxYhiL?=
 =?us-ascii?Q?1PeO3zeFauUJM1ys9kXISNg7kW29RdRfx0xS4j3CBKkbnJ4i9kqJG7Xzk58F?=
 =?us-ascii?Q?eHkDGzqtOb9HIbGXdTq1NhYtoL7L7fvkenRrK+hfeM4z3C/xcG5Dl/KgsYo6?=
 =?us-ascii?Q?fMxVbtxYkYSLu2h68usXRCZ2m9/bMRq6Gk7Ky7qNmJAE7SSKC+Z7WOYQrPsU?=
 =?us-ascii?Q?FFqelvutGPul2tqpAlGbXTQDo3Xi18watrrZD7FYTmZzW8fgC0Pq2UGuyUnC?=
 =?us-ascii?Q?C95QyY9HX/j1tCdgGk7Oqd4Lr0jXh9JDLLwt4h+om/vC485U04s9SYteaEdz?=
 =?us-ascii?Q?iPQUi1zhTuA8svpn9MpAkpJOW8b5/+01Iv8pBpEB0+zYekXlkdIoZRr9iyIy?=
 =?us-ascii?Q?2gRcE0bE954LyVNyXJvHJV6gZJqO8UEAnGaZzAo0LQAPG0MAevOc0JQqocSS?=
 =?us-ascii?Q?j2FBRs7ZlEUzDWtBmb7SCkNTgFUXSsUEuwwaigKF28XXA6FhojhTzloJRrjo?=
 =?us-ascii?Q?SpaVP15PFryDytc1rLbykVMOYUgA+P2VzNSmqMOU1wDfja4f0jPDpKi20jkI?=
 =?us-ascii?Q?k3g0hruybKymUROCYXEzcM3TUMjN6E50UmL8lZy4oAI3b7jTk7F7AaYriwtL?=
 =?us-ascii?Q?Nh6BLgQnxP0vh1xWFE7rYDbC2+utrfBXxSm4Oqs6G91T5BlckiA7UXeBExVn?=
 =?us-ascii?Q?PegGWHlU5MZZIQpkDqOYYNFxfuzkidf8VtnziWNM9QnpvX+GVI4NS+sixBJM?=
 =?us-ascii?Q?FvA8ncifaBP1Hcj6Lr2ujKKaWyQKgxPrvn8/Vj7X2NYF1kb9+sfXYIU21U8b?=
 =?us-ascii?Q?Yhc37wDv3haLLxe5D0cin1AvRh0yRI5UaKGDLKEloEx8rb054arVSgfDfPii?=
 =?us-ascii?Q?VfLGZ8Eo4jAcxGSwZFqZe1PR8H5J1vs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bttAYYw5c9uV5YjtmYIsDvakTJpHDoVgnAEd34VUttST4QdCRZ21mWwVop51ynWda5IP8CeqGeiMhPb3BxqHtM5f5VxjIctdfKNT6xgNNIiR9b/kITNDmvznPkNHy6x5a6ab5cDaCygqpDJJFx93DLAmYOPSkWnuns1b0y2NnlQgSQOtJKoqzLbBZWzRp6byEHpNQNu3bb7aYYg80dNMeVX0BlZkz3p2hQdEH8io4nEfHwpQO7Rc9kKWPT6GKVZO0RTcUnEPnDEQw7FUOQ+9afd+IPUFBhA95VJz43BR1lEZJCqvD/rgc40Nt0i5rm+hVaWlmrYwhgbT2hNlo56bITRawCHWFA8OkfWYFeFhwglKAj6kMzRaP9QDsTCI+UF48dBrBiW3i5fI46HtGPIG4CW+Fq+CP2AnnbeW04QHxB4jNPAFZv+odfhXgRQJDD0fqoS4lFh4/RHGTgnl7BxWoPjp0ohjq5V4wyTbQJUhkQ0zOh8LqVEf4XMARGOCyd8gE93f2IXolyxtjwIHlbnB/E4H+MhPQJ/vCqUvPEMD9RVR9m1trGbv/C225/iYWmzqddVzhdivQbO9QS0yLZxubpQw5o8bVxctIipyjOi5Pho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8868ef3-cc6d-4b41-84c8-08de5ab031d0
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 18:49:53.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtOyfwTSXwd+7YEv16cSTrI32ehkLBjWI6jbPC/lRsyYBAIqA5iikyG7OUPBMR1IN50WDg6wGHl7Kf+Hl05ahfApWiCQfO3cZQLH2zPg9Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230143
X-Proofpoint-ORIG-GUID: 403stJ6hh6PDQDO6eQPm_Tj4pWLOVVMJ
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=6973c2d4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mVEBOKuXeMoa3Jtoz2sA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0MyBTYWx0ZWRfX5VtMcwIDqu3L
 OPmQFy6vBqOiyp2tXtNJuZSNT52FdNie87D8hZ2IqRgnneyma8LQ7Zywq1YmPgJEiMbSVom5oHT
 aow5yU7cuGySMY8QrFNE/XYB6PjeacZSyQor8hJ2Ok/h6qDbxN4JVoFYE1i2mQZ1l6WFQqRAGLD
 0UEySJoHwkOLO5RGERtOeSJgmRhVL4isnl8bngsMyHpDZi1e3meEFWg2mn5oWU/E2ngx0e5cEFr
 7VQM9++6B++g18O0M7+9NLbmjaqOZC8XFlTpDxvS4wM7pLxahzELG3WAfNQdoj+TfUGNGgs+1Da
 AfbGF4TWiaO194N/vzDEf5L3+5o/NAL0MvVzpXnSkCrfJ0IGPVrP5X30W1fK4QRN9vvmA70sXgh
 xLrOpl7r3zIijzvHCVtg1AR0zjMi048z7YbUqii3l/VjoTYqBE8T7P5QvBorc5h2ZLkkWqwQnQG
 WpMSq+FX+ivKxOvHLCAS51iTcCsi2nqSQTpqX9ak=
X-Proofpoint-GUID: 403stJ6hh6PDQDO6eQPm_Tj4pWLOVVMJ

On Fri, Jan 23, 2026 at 05:55:58PM +0100, Vlastimil Babka wrote:
> On 1/22/26 14:02, Lorenzo Stoakes wrote:
> > +/**
> > + * vma_assert_locked() - assert that @vma holds either a VMA read or a VMA write
> > + * lock and is not detached.
> > + * @vma: The VMA to assert.
> > + */
> >  static inline void vma_assert_locked(struct vm_area_struct *vma)
> >  {
> > -	unsigned int mm_lock_seq;
> > +	unsigned int refs;
> >
> >  	/*
> >  	 * See the comment describing the vm_area_struct->vm_refcnt field for
> >  	 * details of possible refcnt values.
> >  	 */
> > -	VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
> > -		      !__is_vma_write_locked(vma, &mm_lock_seq), vma);
> > +
> > +	/*
> > +	 * If read-locked or currently excluding readers, then the VMA is
> > +	 * locked.
> > +	 */
> > +#ifdef CONFIG_LOCKDEP
> > +	if (lock_is_held(&vma->vmlock_dep_map))
> > +		return;
> > +#endif
> > +
> > +	refs = refcount_read(&vma->vm_refcnt);
> > +
> > +	/*
> > +	 * In this case we're either read-locked, write-locked with temporary
> > +	 * readers, or in the midst of excluding readers, all of which means
> > +	 * we're locked.
> > +	 */
> > +	if (refs > 1)
> > +		return;
> > +
> > +	/* It is a bug for the VMA to be detached here. */
> > +	VM_BUG_ON_VMA(!refs, vma);
> > +
>
> Yeah previously this function was all VM_BUG_ON() but since that's now
> frowned upon, can we not do it anymore?
> Seem we do have VM_WARN_ON_ONCE_VMA().

Ack yeah will replace! Already replaced some in previous patch also :)

>
> > +	/*
> > +	 * OK, the VMA has a reference count of 1 which means it is either
> > +	 * unlocked and attached or write-locked, so assert that it is
> > +	 * write-locked.
> > +	 */
> > +	vma_assert_write_locked(vma);
> >  }
> >
> >  static inline bool vma_is_attached(struct vm_area_struct *vma)
> > --
> > 2.52.0
>
