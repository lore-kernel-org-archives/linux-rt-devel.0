Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47539E171
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Apr 2026 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584644; cv=none; b=dwOcDy8tc8hwYL+Ma0AhTZVlpZw8SxMOVidNsIIEAEp+F77bcAASfa/Hka6RePjSpSZxh6KpA9VbNiKPxhuxrZAa79hh6MuE5kKVbhLyFGffRYqXC8n8yUz9DuRPrfhwKANLaEO3q1pfL5RPiqz6LkO5c4eo5VGOazDOqEJ7Mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584644; c=relaxed/simple;
	bh=ZrM6lFX2UCFPg5Kjyem9LHqjHIVlenZXidp39hyYm1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DdBiin22hnoSWkCrhNA2HAgG7KPX7Wf6KV60pRg6MT7IaR2FT51J8GlKOz7T9oq6D8g93BO0AdPstlD2ULjIRgFqKedUf+zK7jDfzXrbaMyb0jVRxh2g049MCyxc6+D/5iKFs0lGBSXR7Zpyz7osdzDG5WRIZqWere+o8411ZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwRk+e9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ocq9NeSm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwRk+e9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ocq9NeSm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UIcIUi1953489
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Apr 2026 21:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=; b=GwRk+e9C/NctBONv
	CIKu36r0sw9XwAGbMoUqHqk8F3VsXA1Z1IX+hsOk3wgNN/JYTVQvbelDoTs3yzuo
	w8ezTKWH7Cya2BXuC44TAdPlRU8SQmaJcMNXiKYwjOFvyRGDKVQfv7I2qgynfWTY
	r3EApPmP70ekVWgvhzJfgC6bVqHdGWbty3vae3lGMFqfi8tOR8I2JqlQts85BqhM
	8out9exLsmmNUug79lT5bf9BYWkq6CJsA+vrOol8mk12K5q2bS7qoM5EkB+ewhcY
	Vr6TDrt5AHoCmUfADKd0AGe5/EbNQ87zJKvejDFn3FAwN2iZke4/njr9CTXoUrl3
	5870vQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvchk8n3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Apr 2026 21:30:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ee34588671so656252eec.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 30 Apr 2026 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584641; x=1778189441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=Ocq9NeSm2hFx3QvNPNBMJ4TRFyxPCSeYDCXrgON/LvIqIghmmKWkjfVXLYZMlDBYP5
         W7C3x9j7fB8E9Q44LB7gcTm/tN8WZMqUY+r8gsfWlvF1e/vbJmfJu9jzT4mP1uDiL1ak
         219xvaN5D2HSG85kRlhzTirPsz5u856YAkRuAFIlHS21HBJu/Sf1u1UGFP8blKEi8MmW
         STwPXWAZtD7eENI9UmGSA5Zs/xFFhiPtDhUbsSAVPj1IOtOYsAA9rr/8WML1BYZh7LeY
         MQdbIsiJnIGEADJCX/jQDbDpGPvm2g5vhOqXOgmpNvzkVkmxQx96ew4wPDlZXk6kb+9G
         1+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584641; x=1778189441;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EYg1mHZ78qeUHVxwPW5soi9NfELbaGNPD7XescIFQxE=;
        b=FS5F/s0XsRL7y7ni6gEHnpFWTwbXY7v9yg1FkvFp06pbyZiTk4sA6wIHiJzbjHlcEJ
         Y7KA0DievT7nq73KBQ6T4fZBCTl08S71TmRbQwOO5OUULTErTHacA4JupghxqOyT8FJd
         66yGxmc9YPzBrB3ekPcdpx4A4Ivv194RaJiT7IntmooC7rMBGAKChEo7ArMGJS/pK+S5
         +DMXnC1SZ2zThbuGhqgrdOOPHF21wMAYbbyuzg7cnxcWjEyqnylncMNqzZbW43Db8hEv
         CuKfVMgfD2VEOBP29ZjnFg/WZTCDsEHG+XXqjLEmky/FQx9Ns9h2g+vIOWyY+kpIFKjh
         dWQA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZzybkPANFmn8eM3K2Asj83X04M37YRGQUdfsSdaU6qefDaYJ119mymlUvxWSAFJlNz9CwxrmArZJaLEp/5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YynvkZhsg/dC0Sl3v8RbwS5NOeQ2Hmvc+K2BzYe9PSiSwJlsISj
	at/vPmQA4EhyDlmvzh/WRsoFuR2nfJ4CWyN+KwgwjnnPY2E7yvfFXql7fSh46QO9tSyeLZOaxkD
	soCxlsTNRbx1RIclUCZeTJBkFqKgMZaQ6sMU33zoGL64T8wWOEJv2SfEbONawiCrgoqpwHPKbCu
	DRfg==
X-Gm-Gg: AeBDietOOAxGhI2g/mPpjhRWuTC2GGGZ9VkUUGUGRSIFIRUQJME/UocF6paEzAtdYpY
	CLy2CVZhzJ79wzEuUIrg9P5sK3qrHuWFdfgh5DV4RKYqA88wa/qjCuU+RVqfxEEiVpDZZiAO7Xn
	bTqMfVJ/n1muBcI/Ubv4JR9uuYP9Ae/ndAsEcYGvZ8t4KkU1LkKZTLEvA8nhSwWzPuXplL+tzNT
	L/vpMYIiHqUL2pb6VoL1uvYXcyYcq1TOAjjVYfHpzkfKyUx20u7GiqglZ+PfeRPfJfsq2qYEjil
	sZkY/DZLfPer2Gx4ppWqzYo/TheCWBnEK4txVA49uqYG2CwUh7CMDgH5kdkvc3tNSzZDGPmXdJV
	o1125mgKw8zEadjGsR+Uf8uhAu6ML4aLiDaB+Y2JlfQzpveBVVzljblrip0TnF3gSAbCiCSt/il
	wGHNfyJSMdBVk=
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496725eec.8.1777584641185;
        Thu, 30 Apr 2026 14:30:41 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-2ed3d5c6b8fmr2496677eec.8.1777584640462;
        Thu, 30 Apr 2026 14:30:40 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, pengdonglin <dolinux.peng@gmail.com>
Cc: bigeasy@linutronix.de, hdanton@sina.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-s390@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Subject: Re: (subset) [PATCH v3 00/14] Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-Id: <177758463946.1848985.4916088351427792183.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:39 -0700
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX0g01y3G57Ena
 pjXjlsIrEMCz/UAwryN+iKQbjMNWThXmFex6djxxTRvBHrz7dk/EVgW/oXw+g2QOkPVLIFFessy
 2Q3HsIkV9WcU4z3LukJiXsx/3XvyGd638fp2hMclepkCO42ry4ajaeRXUwarlVUZZ1o+wTUrLnm
 suFBc0AYc2g5U8PW3O1kyK6KtMdePXymm2ea25I6tuHmQsA1YO3W/MohHNUJP9HTMcL3AnqwVeR
 OYKL5PFPgH88j2AIj/lx9r0dHfrhfcg/asVmsdfw5BIW2daajFvJxNFajD/4+w0VfRmpH2DmXBW
 y60lBEQH6p4wIuyh58ImFWWHIuMn24LJJcPTPr2g8dxXihs/CYgYLBsKniCp9y8AE2Sei9xVxag
 +bxIsSSeyZ/821N5PRsWa+fkUOLI6d2v9n5znK2D5BPmnuo0G6sNqM6T2luGRzPEKDcrVc9wX/U
 E6SF0IvEsaffEi22Gcg==
X-Authority-Analysis: v=2.4 cv=Zdkt8MVA c=1 sm=1 tr=0 ts=69f3ca02 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=R8he2_Gm4Sd0DFq6ycoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: 52fSrFsWCtHXbh1-bIGsIvNNYsBXZRE7
X-Proofpoint-GUID: 52fSrFsWCtHXbh1-bIGsIvNNYsBXZRE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300222


On Tue, 16 Sep 2025 12:47:21 +0800, pengdonglin wrote:
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> [...]

Applied, thanks!

[14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
        commit: c4f518736472c8cfbf1d304e01c631babd2bbf34

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

