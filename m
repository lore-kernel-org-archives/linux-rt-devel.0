Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA935C188
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Jun 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769769; cv=none; b=VHDyXfFj0PO8DRnjSa/K9leqWUqz8MK5H8e60RK9lwHdp67XWtrH/8raEOhw73pycywN5bo2TwIdVBDfZ9+WW0w/wlXbkiJK3/QJR9ZUq4Nw/kqeQSXrWiLRbnrnWNVoNNL+HLfPszU4IRBsOMwF2uG3AY5Z/Ed0gkLdrAKeScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769769; c=relaxed/simple;
	bh=gIgwg07NhORFUo55PNg3iYZiB2iaD8bFHZEEN6PAB5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbN+jadWTlikPb8pkG6qGD9SXcgYXH48tJD84GAeBGnCDIdpUV4HieA88ssWg2yszxdslpLAxnQJHdMKbHMy/SSVcCXzUQuRdiF5Ue6WKZrcT2HVfbGkICyDMmGNPrM30fONLM9g+cnixV4PMnTtjdT0X2rhQN638U1CGfQgcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oO7GsKla; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X1Rsiygs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oO7GsKla";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X1Rsiygs"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I3Vc13330433
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Jun 2026 08:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	19ANMkk1VCbapB4V6x38n8KnLEFh2G12hOsdryCZYaU=; b=oO7GsKlauran9N6W
	4Eyq7Ds5xg+WIMIggsGFVyfbnavGi/SgXju1ftFMYVRJ2iUDGB02Tp7POWMNE0cw
	+qDZh3601E83ynlCU+8FF2aSCD5f+wgvnpeAp3/eJHP+ZIJkNEc1137qaYqan0E4
	C2pWVbKcbDPhYoCjAihF6C+0Rn11F3wJX0Q1BEu8zmuaVkcCpBHrhDQVQQEXZEeV
	ppfUG2OxMyklhPkLMEjXUZfIeA/Sfv2U/Xf9L6KzJO+TAO92nDGjkKZ5+oDNrP7R
	tc5RUI8etQ81IRZvWrMOjIwGEscPC54t6BsMErezvKaDxCjb/xI6X/WOpoMqQaLG
	c+5WSQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vkx9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Jun 2026 08:02:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157de5360fso369611885a.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 18 Jun 2026 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781769766; x=1782374566; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19ANMkk1VCbapB4V6x38n8KnLEFh2G12hOsdryCZYaU=;
        b=X1RsiygsdZdHGw3ombkTkZCC2JrAcWIx33xoHu4rj/doGkA+6s7J4q4FV+cRH3RKSL
         whptEHtV6ptA7yUjRYqoi68jpCmIpW28oKueCKTomAIKycQslQ9EurCHueobcu/p10Fv
         tv5mUqBnQm6K4sMo6MoNhPOfM08glLH4+n6t9GM/dOyf8IR/Ldb2EjoXW3r0G9qYTIi+
         +D+avuLwNFie22farzrl0HFPWPuSStcfk21a62FHPYSJ1z8OMRAqUIKdLgDqlQPnD2JT
         ppugfGRHkoGefT70o+NGmd+ZIAGx53HgghkReWeqheG4wu7q1DhdsYsymPwDbbPZXgtH
         wjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781769766; x=1782374566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19ANMkk1VCbapB4V6x38n8KnLEFh2G12hOsdryCZYaU=;
        b=hsw3Y6UYbBOUFl61QW+EqeMQj0hLl1ItY1zjsXgSQ3hk/EyBmxSGhx/288ATHek0HZ
         48TI+SGkkvliD7BqUxviMGd3zQBuReWdjihtM8J+0MVjHNVCIZyfL0Rz5tovJbLlR/TO
         kNlKP3vxbVJyu7xFSkbSNzLD3RhlNlVhODTcamGcNPPbDWaG2vOYaXfQtDX/VYkQQ8An
         Tvn9jecEFPU9z2Ulurs13OYuPiFxGsS/TBIpUa8/YZu87xYxswgxL9HYITbQ8LF8Dlui
         AUOQwmT4hBUmRlNB4u/mhQGUZPwI9bjeJGp68i7KMwoJomMqWtCtuXHAErq+ZMW1vaBS
         z6hg==
X-Forwarded-Encrypted: i=1; AFNElJ+ux78VhEpJBT2UhqeUJRArzQT5n1lO/0Wy6HwLYlk7k3BTTlJXmqoPKCMdWHTWkNfA/1fsrkEFWCjOTVdZVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznH0MBxI5pQojeGptM4KQge1kCLAfXecEnLOl8mS/blk3EEhmg
	EZ22qAMRyA77ErquNXEttkh90+oHuRUnGi3fZTWkt3bKipu+wwRUPQgxAhOmzVdh3VQk6u6tZOr
	KGpjprWvn4wuxjhh4VccmkDleAPfNR8kwCnC5Ec7++nnvRUg8OY2sOknVCsDxXpbCeIUpJw==
X-Gm-Gg: Acq92OHPIiVTEcxzLwIzV/8JtxtVBlBlHx3LWon+QMk+qaeep13ZLzRFYf6s4IP+5o2
	WS/1u7LJh+hqAIxUhHV+3AANS9SoeNXGeCaTpWlmM1mUaNPWCliShzQS9tuqatV84yUDbutq9F6
	eXRVh2NriPltTwtTNkpYAy9nmG48qTCl0MilLKF1eloiAqUJaQejC9FnlM0uPB/ikNcJ/6Ul6YI
	efoVKRKcnGwvCDRbv4t2Zw44/yCIDmzrdEe8PtOAKXpeQIRmgruRwjYJJ5LmtRaAij6gfI34ekI
	YQBG4BnPe4XqTrMiVUYVau52uLvXBZPP+ybaQpedKnQDnXMtNZ6JFE6zl/7ZOKho9b6jbT6jbpl
	VTq+kTGDsVoJUzcaKi8Y3nA4bU7ZRwW+pK0OJ/wQ=
X-Received: by 2002:a05:620a:469e:b0:915:8f64:604c with SMTP id af79cd13be357-91f082ff425mr440346985a.15.1781769766272;
        Thu, 18 Jun 2026 01:02:46 -0700 (PDT)
X-Received: by 2002:a05:620a:469e:b0:915:8f64:604c with SMTP id af79cd13be357-91f082ff425mr440343085a.15.1781769765846;
        Thu, 18 Jun 2026 01:02:45 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:41b6:7808:5ff9:cd42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923a1c3c4esm21638635e9.1.2026.06.18.01.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:02:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-gpio@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn
Subject: Re: [PATCH 0/2] gpio: use raw spinlocks in irq startup paths
Date: Thu, 18 Jun 2026 10:02:41 +0200
Message-ID: <178176975701.5432.11843620279684767377.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
References: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Rvc_1N4Pu9zi-dnjXRRbpGHstCxQz30j
X-Proofpoint-GUID: Rvc_1N4Pu9zi-dnjXRRbpGHstCxQz30j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA3MSBTYWx0ZWRfX7lIQtUzi1a/c
 ZXbbFU5+pWMn0oM8ftYpOWfiZn/FXDKVDs2W3flNdo1b7r65M4zA3fWbPrMo4RV2DOYccoP9zc+
 x/keaasxlsPQZuVVO28LC5SZWqzRa5Rzy5F+wRurR4AB9mQuhCbaYCx12bb1LiKRSkCBkKqSdUM
 hFc0NKFxejI6FT5vNORpPvy/RyybswisXIftva+Bv4niQoddQnlGb12hYmdSWVGJH0bav6Xtdgw
 IXU5PMW7ZQiPgsSNvJ3DvlKF7ZPpIDSjkgJ8QAibFZv23i+yqajKRDHKnVIgPNgDGgbssQNGKgv
 h7Y1cI/uxV5u+U2ILYLjNM5Ycd1+bDaNTjhj/J+6ax0jg4B7viXTC7gpDmwDu7NbGqCu5HbyigF
 LGt2jx2qI5lIWJctRe2UlvypsA/qK8nL1pz/f3QCeuJERgLN89MybPnM/T8P56awGqqm3WXgSxV
 YZU/qfMRYmRsLrnrHFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA3MSBTYWx0ZWRfXzZa+0PnypvyG
 YQy/JUXX3W0MS/kO8BQFCRj7zKG//rHaR2mAxKDcS11euvxysCj9f6lAX+x4Ir1iQ48gpusHHnJ
 pdNkV1ZGgDQ5B7UDGU41OC2TSb1MrnU=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33a627 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CTdToGyfExxhxWjKcZMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180071


On Wed, 17 Jun 2026 23:40:33 +0800, Runyu Xiao wrote:
> This 2-patch series fixes two GPIO irqchip paths where IRQ startup or
> unmask can update controller state under a regular spinlock.  On
> PREEMPT_RT, that lock can sleep while irq_startup() is running in a
> non-sleepable context.
> 
> Both issues were found by our static analysis tool and then manually
> reviewed against the current tree.  The grounded PoCs kept the
> request_threaded_irq() -> __setup_irq() -> irq_startup() carriers and
> Lockdep reported "BUG: sleeping function called from invalid context" on
> the corresponding driver update helpers.
> 
> [...]

Applied, thanks!

[1/2] gpio: sch: use raw_spinlock_t in the irq startup path
      https://git.kernel.org/brgl/c/286533cb14a3c8a8bd39ff64ea2fc8e1aa0f638b
[2/2] gpio: eic-sprd: use raw_spinlock_t in the irq startup path
      https://git.kernel.org/brgl/c/90f0109019e6817eb40a486671b7722d1544ae29

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
