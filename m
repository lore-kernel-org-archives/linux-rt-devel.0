Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8140B39C
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157697; cv=none; b=oNRvaEHtv7qNF8Hw2EB8uOuha73fDC3qSrUC4DX9ZEkunNC3W/y/PlA5gv6D6MtyLu7OPz5u8SsRSQ8ewgkFW6QADisM9w7r6lcxtFYDfiFJYjCBhlSaijUXj1h4ztVp5m3fU9ODXC4QOGclnk8/UJs3tmrA5gBDxl+6Ljbsjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157697; c=relaxed/simple;
	bh=HYLFS+OFcWFTtSFm1PiU4CCDIq1dnlVTeFE2rXyTcVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlxLCv+6g8MrgZm0i59eIlq4m+D+aD0rGiD/spArU29hRohcfBxm0WRHc9fDmtAXiJH11qLOCFmqri8dMp699G7AJhoXG413j93inB97ugGOHFOe7IAh2ycjwFq8iNVMcKQEEIlfO5S5g1hAZNUsK3huadN63RarymfnEmMYQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZW+gRPaN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eMml8fJo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZW+gRPaN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMml8fJo"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAMK0U3197747
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 13:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LZHWggkPMw97tiUjUmvN6ppmZKNPFHubbsI0aW0BRH0=; b=ZW+gRPaNKY/yucJS
	oJd/kSuFbPVjfpEj8uMQSMeAxIlBsxYYC8FJKKcmKeJ/AXu60CBCOoHcxbX45Rzj
	LwUXf+AjR5YS61fmWC4o4H0Cvd5GhNpZ4UE3wihFmNFAvZkN/j14yam9Eu27t2cY
	6F+AbrB+iXOxNRAjlkurLNyz6PCGkSisttOwPznaxyCfc9uL2NB4pofg3xfyjKmj
	VR3QXFQ626o5cBR08gb5BpnXd27j4qhMcPJOB5cdVWpaTpAYTA+GrmYMBDlMDVdg
	EeLkZuaiVOXgDucY12jlfbiRp86QZMywuMNZNXunX/4fyOnzQd/IOShdHr1X+TxI
	lCWewg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp2ashhxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 13:08:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-522de3c645dso56026561cf.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785157694; x=1785762494; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZHWggkPMw97tiUjUmvN6ppmZKNPFHubbsI0aW0BRH0=;
        b=eMml8fJo4QXv/qx8fqi4PnwYG2ccOS1+umtuRxROOlnYQS0guIwcagbsVwdF8wbmT0
         3OAImUSY+jgJKvD1l3ujwjhXOWPQZPeYjr+qeor/4lQKbEBdyh+9hSdJZOMOdJO+Ysxy
         vnt+WjJzp4irkT/5h2jGVVTdADI9zZZkB793IKtOuTB5/IDqMwaStExFJFEIFOle8u7R
         YPIYsJ4YABj9klEeWJb99Os9rrDhMlOhmsicyet2TjQ7NuDyy5RlimTlkeBWgmBvpIML
         twoSelDg+DwPGD2jmF7O7pFQg9rXWYJOvm8SU566XeTcCqsyXCECqpmlFsE77u8KXFeL
         XHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785157694; x=1785762494;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZHWggkPMw97tiUjUmvN6ppmZKNPFHubbsI0aW0BRH0=;
        b=ltQ7iBOF9tqjiZwtSA8pPUR1dU65GtkfTL4qq3hMPbBQWOuR+0xHigrFsaJpSTgeod
         vQljs9cfzNe4f53OXSopPml66uXhF5qrX/YJDewveTOrSaM3SbXt9u3h6yH5A4oByemo
         K3ifwUk47nFQdKeSzxdTWu/joa0AFb46EL2Za+SOc8/muIZZAqqaMNaKzPB6ZHSVGCJc
         cv7atsDOtfyyhzBkXUK/aYIA+LUKbGrzViArm26VzJToWP0zd1svMvaNaJkJwhyJbTal
         hl27F8okpF8x9luHQwT3q7pDp1qGeYOit2vwM32zw5VdxY6q3GmVB2xSqbDAkzmFkWwH
         BJyw==
X-Forwarded-Encrypted: i=1; AHgh+RrS6B+8p/I4jc/+2knETeDTqTR2LbzseXdqPhxSXxiZWBXT1lV57d4AGCkX8A2k+C2m0KCpgVRDjyUBD4fvvw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2LKvtjMiJSMjkOgz4JWwiolXGnStvMHTTL6MOSjM0xm9Zudwj
	FzwvU3jcCB+WMXRCNUJTtZQk/ut3L8mVQ+diOu920OeJ48m5d8PS1YKjqmcsAsmQ2ScfUBdlWpE
	8ePI4iVHNTqiskxUT1do+OhQz5R9xe+a0OuUWIkV2jUrc5IKM9FkcsiMFC1EQfk3tZ4n+0g==
X-Gm-Gg: AR+sD10+bjdK+lQN+KcGR1KK2Y9YXBw3emKWZglpKWvkns9hg939NXTQWNAGkbbiGlE
	++lh+JdcDcYay/cD+OHLVZMCB/Lmi0t5hxbN/BAjnxuL5R9lEWhBE8BdkctOUKpDw+zrbDt54dK
	QDmbYfWnSQvQoJWGFmXrnWFA8YwWcV23ByyQ8/TtE6ONpMboOqRThvs0wB2V0Yql6oHxagdqtOP
	7qxIcpGbWCxh7rejCOsKCHK8C+qhpH9JV2RsAEwJXYS973gX+gxHFbAtUKh8JNLjU41g1GhsVV9
	TpDxzKMVc1/O2DxGmouJaWrhIEPs6KhGgsiHcKF2nOTC4WvaL176Rs3D0+v1igXQ7NwkB4KlDR2
	c+vpbJNUNJS6Lfa9lgg31QkrCozc=
X-Received: by 2002:ac8:570d:0:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-529a84bb82bmr84853341cf.22.1785157694164;
        Mon, 27 Jul 2026 06:08:14 -0700 (PDT)
X-Received: by 2002:ac8:570d:0:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-529a84bb82bmr84852721cf.22.1785157693717;
        Mon, 27 Jul 2026 06:08:13 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1449:2d40:6dd2:20d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe07e1sm233635795e9.3.2026.07.27.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 06:08:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Junjie Cao <junjie.cao@intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [PATCH] gpio: pch: use raw_spinlock_t for the register lock
Date: Mon, 27 Jul 2026 15:08:11 +0200
Message-ID: <178515768299.55050.11621180913720960066.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723014129.1129730-1-junjie.cao@intel.com>
References: <20260723014129.1129730-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEyNyBTYWx0ZWRfX9VIHWypCZ3Cb
 X/4BUXwpkdKo5TOe4w2fIo0EbGuxMm0KIU7kxPFdzXfM7zpU0RXVv0tRYDsGiYn4tCSkS/EmcTo
 yWahaNmYUy+bO2ZJVHco1qxNNqA+VUixm6dB6Pu5IlyWHeF7k7dUY4uLLBVzvUrFRczabb6ivsw
 bKS0BlPRn1niHb16wGl3ElCaavjUu5pd/fcLtsNHCzfSHEkaaO6saBOewCDLwDiyRm9F04rKkKp
 Fv7g9ahYb262O0XQduQakvve1ldGtq15p21KaLCFqIdNSo8KMO7yY4QGs1DHZLvoINNntCBRAaa
 EotS1nbPZlMWVc7GtZu/HTM+/LpWK80hfqumooxGv1B3rSRpwGCVQJPf0NAKePLNR0rm7PJ2K7k
 RwUxtMDqgGYW/UGLVS68GF5+0QkLBRAFPI+8I5Hm8/+fqoRWAX1U1yAA6nF1GS0BoVfMaxU9nVt
 h9dcqgz6kURmIQd2ZWg==
X-Authority-Analysis: v=2.4 cv=UPbt2ify c=1 sm=1 tr=0 ts=6a67583f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=K0IHqChC3_vQdOeRQfIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEyNyBTYWx0ZWRfX1jMdd96Gi9sx
 ljANR/+9W50qdnJeyNnng2z18/JT3ey0Q3fYNGOptGUOzmCMOc/bL5/i+mnSwUIP6OcPNlDsF2w
 Rbgp5XADCMS9JwbHaAQ4LNCt8DAuoD8=
X-Proofpoint-ORIG-GUID: MjWTp19pgaPzyFRKVdJsyag3Il1Nou0A
X-Proofpoint-GUID: MjWTp19pgaPzyFRKVdJsyag3Il1Nou0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270127


On Thu, 23 Jul 2026 09:41:29 +0800, Junjie Cao wrote:
> pch_irq_type() is registered as the irq_chip .irq_set_type callback and
> takes chip->spinlock with spin_lock_irqsave().  This callback is reached
> from __setup_irq() -> __irq_set_trigger() -> chip->irq_set_type() while
> the caller holds desc->lock, a raw_spinlock_t, with hardirqs disabled.
> That context is not sleepable, but on PREEMPT_RT a regular spinlock_t is
> an rtmutex-backed sleeping lock, so acquiring it there is invalid.
> 
> [...]

Applied, thanks!

[1/1] gpio: pch: use raw_spinlock_t for the register lock
      https://git.kernel.org/brgl/c/a02b8950d619123da64f69b70fe1dadef217dfe4

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
