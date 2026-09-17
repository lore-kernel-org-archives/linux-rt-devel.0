Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A524AAC65
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638767; cv=none; b=pRmIH1f49NG7Awj/e4JHpto4UpfaIHDVC1AC1focwqvPClKBoWutkQ9VE5VqETqakgLxdrXLO18HXnwTWH3bLJ7knAx9edafvKsiRo/h1ogH9cUQ9VQ3nlrjPlEnVc9LRIDdDcam9MQGANuGqgzsv/8c3yTRXgqCE+uc6f5uKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638767; c=relaxed/simple;
	bh=eCh+lQ06Yqem0J/L72w7Iu/+L9tJW4QJJeQpsqN+QMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdQRsgQCWTvS+YPz6eKHJRIU1cyxY+jFCAQVhOyukpyZQMnU2kLJhucPYq712OIWLfiLMVHiEoyMnNGExhyJsUq2qxVaedzT77tViGwGmlaG33p8/FJio2TDACoDfQkl+nmHDJ9B6REE9VZhydWC5dI/bXdBHFW/OgxK/5bsG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lRQanFvj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OXaX8tHq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lRQanFvj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OXaX8tHq"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9Zap0746566
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 09:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vj3q1rEatZbNYhDgOOz/n/ThSNJKjldYi19PJG85UUQ=; b=lRQanFvje23OlNKQ
	KqT8zUnUqp9FPzKbNr2Gp/oUtnxjUzP5x2c3Vx0qs5WOceuBBheHn5c+vaLRpr1p
	pmRHnORK+zWx0bptt3/Ziu0iQ28p6ZkZVJFADiywpEDfa0Y/OzgLkmCdlpfvEgY9
	tsVQzZVMDqlYrsH9PR3CfO56vKLrM9NXiDqxQJzheWDVaMyLMCHEYG1e4TE12YOF
	aLuNAC6eNjLFTfgMPJ4vV+Q+6fdayk4AT45G+lO/hhpuggvk0RAQJzLw297JxqEK
	DOW0Xjbcjk4BT5MUaX5zL0F127igLsF2719KgmJYB1qPwvY3t4wZv+DT4b6fmoO3
	UZRpIw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grcra8acb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 09:52:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9104eedb5b0so11213936d6.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789638754; x=1790243554; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vj3q1rEatZbNYhDgOOz/n/ThSNJKjldYi19PJG85UUQ=;
        b=OXaX8tHqev1+h3zDOeRHpC8FHBBOXFUhn/UnZGUmYcnn1IDldtc88v3yWvtyYRpli1
         q4W9D5fRhyJSNNtTyEBGEVJKIzmXAgxIjlwJWk2GS456bBHJAFPwHp/GFhGaIXma3OQj
         QPUyaT/qwygCu3wWM6EQwYRiQIZb5hHy6QkQTndk0zkSySp/M/vhKOFWIR0BICaBOsOx
         azxj91DY0kW8IFUzYpHQtjpYYJe7rMQx2z7lgtRcneayXC7ACiXddMMdZtAcrOIzXRPz
         O5vMy1XA0PUIXiMupTBqaPqkeK8wmqpdgGKlF8fZCpiUKgszj1OD5NpuAJ1v+bJzuagK
         LSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789638754; x=1790243554;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vj3q1rEatZbNYhDgOOz/n/ThSNJKjldYi19PJG85UUQ=;
        b=wejKb97fm+RzobNFEwyT1+EDkdREvlxDHspyC6NlL1+a1IDVO56NK9O346x6UCC/4P
         DYq96Bk+mFBIUdKJQt0a0vq+aQHr5T0M1Z6/hsoItLhdcYUy+8HtRCS6jBQs7iwgmhof
         8YqgJY2xbpIwp/dfgo6zN/umL/fiY3flj1glyAb8o4NR/8FJNWANpX1haLSjdKBxMJ2g
         X+yJpWWBtXW2kUK8/ABACjkyy4FvkP6WURe3IdtgGFpYMKjHkOK6KCQl4cIPY2h7yHtH
         mDpOPGW5uO6mtnMxZdvauiCLsgmlZMyAa+zStwwbrp4K4Myssc35sz+MzNG2GznmeOhJ
         zf2g==
X-Forwarded-Encrypted: i=1; AKwUvByFrD2AW6tY7zT1+9QKMhmG/PV5n0PHFt0Z79E1FeDAnEquzCZ2eeu7nSw0FqvwvX0s7UHjjWkENhGqCyb9tw==@lists.linux.dev
X-Gm-Message-State: AFuF++mCZ8YYBjfpjgkaj2g6hy6QC7x9YMlGL+8nlg8SBWkC/3UFlySC
	t4Hex9TyC9N3Tizj6MO6GH5wtUWnkeu7qy+dsJdgUdDD2WkIsiVjoJM/RL1l3vEQbx8vH/DsNU6
	BQSlfqy3Vqlcz87IAY/OPgTbSfg52VmWr5DbYWcUh+AOEDBvZ3+rHAabkbmG6YHcVo7vSXg==
X-Gm-Gg: AYBFou1NiBlPb8iLtKZuK37s07RZVYH6qqjKJOeUDutpvv9i4F4Q4NftH6WHoghHKAB
	NDLU4KrMHqHC6A5wEhe/r+juOSxT7g8qj64be+Wp63EJStRwGgRQ5qiGV3BaA4ixo/vlpNzwWLX
	1TWpWp86ltUxR/MfZMD5qeYfNpmzPDb4bBV7K2Y5KaWw+wmv7Wwf4D+QHHxKHx683QdWs11rE4Q
	BPBl7SkiRx4RqwArpK6ayk929dOcluXMzQonkUVwGkcJSrkOMao8qs6xEyWnmM1tVuOPNbSx9D/
	LTNy4z0FkLzh9DHCvMWY1/1enrrpKdqs9OOGhjcJpcrd6DViHs2HxcH+8cGX0AXv+8/7Eugeip1
	L3Y2c++e8bd6aaezxszv7dgwq2rM=
X-Received: by 2002:a05:620a:6188:b0:93a:82a:71e5 with SMTP id af79cd13be357-93bb7703f59mr919230385a.19.1789638754216;
        Thu, 17 Sep 2026 02:52:34 -0700 (PDT)
X-Received: by 2002:a05:620a:6188:b0:93a:82a:71e5 with SMTP id af79cd13be357-93bb7703f59mr919228885a.19.1789638753876;
        Thu, 17 Sep 2026 02:52:33 -0700 (PDT)
Received: from brgl-qcom.local ([90.161.207.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd216028sm60330255e9.7.2026.09.17.02.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:52:32 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linux-gpio@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
Subject: Re: [PATCHv2] gpio: mvebu: keep resume masks within the irqchip cache
Date: Thu, 17 Sep 2026 11:52:29 +0200
Message-ID: <178963874726.7902.8784965092061133801.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915004406.115230-1-rosenp@gmail.com>
References: <20260915004406.115230-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEzNSBTYWx0ZWRfX7On1n8irxFzd
 wOS/VNYh/VkxOGmfbnv7VSjA2dh7fbfjo+2DVERhAQuFazbczsdXMXzMlv5dRgPbTkO4P0HuGm9
 Ua8LrdjSncYIYqUW2Nr/FeqRRFglJOM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEzNSBTYWx0ZWRfX2yA504a40M++
 yu/t12kK4/xdajGQmgS9L8LBKvOjxwzf02eoRIGys4YKHYxMs9xj0yl8sV0MZx0LRtshe4N5fbY
 9nhj3iQI8x2FaAmcdfkpITygH+rZfGULRxKP7bwKWo0V/obrM8jS2UMpPkMctQedJGbPkZK3D9O
 rdwCOacC520mTMt4WzvtAxChf9JS4tdlT73hkjB73fyBrpraIC+cL8owmnnzbvqIpTuWyvd0Tc2
 r4hZuYcCtxwANNErBD3vQiJaslDQDEh68KIeK8HH4lIY7ddH+/uAQpsj2vQGfdbdYsvZm/uYttP
 FnBler82vCaQjGA5ZEQkOOdKF92ScSzztBeTy7dOLcq4JItjzPe5s52AqLi6XLso2QIkr0LXsei
 cPOuzkNNQ+ksD8+utfG2hGM7OPRcjcSdwv1nySErP9ow2kVasqeZXZa+/UY7h5AUfrWK9wnVsAm
 XMBTXgdB0y4ZknWd11A==
X-Authority-Analysis: v=2.4 cv=WL/qzXsR c=1 sm=1 tr=0 ts=6aabb863 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=BQ2oiuy6hHN+kKmom1QVvA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hD_7jLK3eKd2lVZaDy4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: HHPQDkwmZBmEtrR-rynqbpDAd2rGJrG6
X-Proofpoint-ORIG-GUID: HHPQDkwmZBmEtrR-rynqbpDAd2rGJrG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170135


On Mon, 14 Sep 2026 17:44:06 -0700, Rosen Penev wrote:
> mvebu_gpio_resume() writes the edge/level mask registers saved at
> suspend time straight back to hardware, bypassing the irqchip's
> mask_cache_priv.  genirq skips mask_irq() for a line it already
> considers masked, so restoring a bit in hardware that genirq thinks
> is still masked leaves that line unmasked behind genirq's back.  An
> asserted level line then has nobody to ack it, and the moment
> interrupts are re-enabled the chained handler storms, hanging resume.
> 
> [...]

Applied, thanks!

[1/1] gpio: mvebu: keep resume masks within the irqchip cache
      https://git.kernel.org/brgl/c/02af7eac17bc62a72335c1fc8c4af4471654f6cc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
