Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328433372E
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504975; cv=none; b=Ya6cEtmwlsxp3ShRliEfSU91nA+/ZzerPO6llCbVGShGYgjZyDqZT0NNJ5ullTSsrZCdAeCYWN9LeosYMwX4nCbnnDKzMzzLLsN83nviDQvJNwEC+KidN/fnBej5Ka0oHpzvOldKdYnezoLRpPj+/pdetbJno33zuwDVKb+DIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504975; c=relaxed/simple;
	bh=vBxG5RDxo3M2CelAyi66+f+v8Jpm8sCpG7uJTouI8eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3mBcbORJzxKvaeiibLvsOmIMwTIsNw5dANF509PJa2xLohSjjXZRIm5PGUZ45ahsaCB2c57OzSuovfK6TCs0EtpZNnAWPgHmJHZlJe8KrWn2Qj2F+HSlHlmlAdbfx2C5oN3Va+ZBnx4zBa3DrQsUCCF+5BmG8BXI8fQzAfGlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVbXKfpC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PDgOUE9Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVbXKfpC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDgOUE9Q"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R87KBK2379285
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 09:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dGOdsBQK34H/OR977ehhBWPGuUMyto65cOXjh8VO3OI=; b=aVbXKfpCn1GE9UQ+
	t0h/fGfCjtFOV5V7khv4wbU9CB0ZpjQNMpX756YjipeOP/hcNBPRZVBIzu/Q2Yxp
	5+i8TNWapEHjVnCET5KWstdVH3wMaxqt0cjFkYUZ3izWl6cg2yoJ6/uTHKarx7mA
	7QucXueG2XSjH7pWeNxocC9swXlRayCoNwBjI89pnjOkb3ZPhS/pNsDQInh3dBqA
	uN0fA2CA4iQsMf4WgdqI5xz34Q0FXtd3S2d4Z9G7Kx1fn6mVOR7ipx98koKX2e/1
	gj3v846hspl1XEsXbTrb9GzxTAdR761pgx5JwjLpMvhHA7wFZccl3t2RTSJAJt/e
	tdfodQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjr86vy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 09:09:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6b4058909so1269512185a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 27 Jan 2026 01:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769504972; x=1770109772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGOdsBQK34H/OR977ehhBWPGuUMyto65cOXjh8VO3OI=;
        b=PDgOUE9Qb3Hl0iw461/LBamJzYshHsZ+fazpITW4uHmk1UuzOYf2XGyOYPhP0TDrHz
         2b3d1XKEP7QVDBF+cVhjn7Wk91icJcXOzarOmsXTrhyTA7h6JyMrckRpvva6ZOhqcnM1
         ayNUIzDqwe7bLvkaxsy0b3ei87kectcqn6rVj6uKD+u1Qpmo81MuysPEEtj4rQukCJGH
         eSEgAJAbOyIDPn5IvOSCqcd+R0E2CgwAqyPrr/9PSA1bFQ7R3tTZpHwN4js7vDRrNTwq
         8I6aLJOhzvzqvs5Do3/BgFDgH23RmbfoodHbTqyj1JQasTUeUrcGzup/KYHuNUgYlEZM
         f2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504972; x=1770109772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGOdsBQK34H/OR977ehhBWPGuUMyto65cOXjh8VO3OI=;
        b=f8xcin6tIsTiR426bVjIZdSirwkg0pqUeQWcYpctapQalYNeJIrSy685AdaocH+LoX
         iCqu893gH2GHdJJY23/8V7lqL64ghs59jsXxqTsizWCBDc7wgWvX94hUQ3tNSTG8IvjS
         tO2cFBbWh94vEl0Fav8LeKxbFGo6cVJcFqtWEZM2CrjyCwACPH9JICHdL0tJcowvSVXV
         IJTkwS8XfY5koDGgjxNXWEeqeuDrCJyQclaCfHt56u5+4yvZKZBcg5qH0FzN6Ml4uvDC
         rhb/cyT04nCnFxaE0X04x/RMNhj6u/BLbb6fXti9NpNnyWp/PTjMKGptVkclCn++dYEV
         i9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMUhP0FxV6q+VXoEEgKo/MZp3pXUAP0slA68/mYZvMky9g8CmmP0aAkKs/yfWXegNL3AoDhfU08CXGxjwLKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHETi1QwMVmulC0YJzC5iqCQAEuxU1efxx1uu1Z/Wej4TfiqgH
	AUBBZctbbibhls9ZoHm0qP3cZdM8pBoSpM3aSqzNnMcZnCWGnrkp5uXHB4Hwd0RjyoPwtbgxLN+
	SVpUQM+mc46cXzayTW2ucCFU56qQR9YeOmCC1tsZQWu2fB9xMGwXjVGOp3ECoHEHCIlBnzA==
X-Gm-Gg: AZuq6aLEobAOEMA7f4GkstoeJP7Ft3jc+PaD70YxI4A6WEGm/Rv1fS8dY3W0OlBkePl
	jxVCzRToGn4phhNKUuZtSLfkSfRddGJF239hbvSL47SfAhd3BcVMfaPLDAphZZJhpALE1V+5WME
	oPn7af+hSzqkFRzziEJDfM8w6IUMtL3bxt45vzsowCsWuWaM1yvza2xCoZnsEGeYqCqR19ORPbO
	2xAkD9umT9kJKYFvd9ChqatJT/+CZmChRUEps2WHYsXjJwmb5WTsVjwwr4/npb7YRjfiZtTJXMj
	fVcM+adwwrGUmxLMaP8agHmeSKWcLxxRRDbRDDk2E0HWndahg7AjsO3ms43WtFo/PzWq2nVSk3b
	zhFSjBxKiW1QHo4+pRbsFwaLT8f+yQ4xR8I6KJA==
X-Received: by 2002:a05:620a:450c:b0:8b2:db27:4262 with SMTP id af79cd13be357-8c70b919056mr104369885a.74.1769504971813;
        Tue, 27 Jan 2026 01:09:31 -0800 (PST)
X-Received: by 2002:a05:620a:450c:b0:8b2:db27:4262 with SMTP id af79cd13be357-8c70b919056mr104366885a.74.1769504971385;
        Tue, 27 Jan 2026 01:09:31 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:262e:d32a:e347:8b74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804db7b434sm128163345e9.4.2026.01.27.01.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:09:30 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linusw@kernel.org, brgl@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        Xuewen Yan <xuewen.yan@unisoc.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, ke.wang@unisoc.com,
        wenhua.lin@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [PATCH] gpio: sprd: Change sprd_gpio lock to raw_spin_lock
Date: Tue, 27 Jan 2026 10:09:19 +0100
Message-ID: <176950495238.13307.5466333816123432265.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126094209.9855-1-xuewen.yan@unisoc.com>
References: <20260126094209.9855-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _3UIknZaJBqXZj4QuY2t8T56ia0Dp0Sf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3NCBTYWx0ZWRfXy4BCMejNTyIT
 aDk4uyKKykOtBm7tvKx7HjryYmENKUbYmb+T2UPTHGx6nygRNSXb5vnp73G5e0bFbDbClmvBJW9
 VupWGK7as5PBNEOus7dboEwg+4wd8xPTckAx7VzOkRixBL2lAZI1JDIJQZXS5BrdDocf/IwoaNn
 6qOZVSr6En4MohMOZuI1H4ambCj2+ylN8ZbFqTkTYvdO8neBJ1UuSSHgyBBPQRzy1x0HJ+oHPsL
 PIsihvIxxMUOMqONBo1sfR0ftnzWJEiOOw50WC0LAHj7wHWSDyDIA+Ya2J7SSuw/Kw/CS9il+Ta
 xkiU2QLT4uO1/YvyAwQk2GDV2JI7eMNaM+9DGiHUdsEpBhWet1T5Ky5QSfSBsyCeIuRKlxqxtZX
 RalK3VBwbql6rvo+xrNND6M+1tqwhi+Ahm20hayEer4Lcv2yR2pcoGq3zvL7Zfs2iO927dGwaOy
 dIaj5I5Kvo32gGemZzQ==
X-Authority-Analysis: v=2.4 cv=b+i/I9Gx c=1 sm=1 tr=0 ts=697880cc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EoAGHgS3sxU27ly2rhAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: _3UIknZaJBqXZj4QuY2t8T56ia0Dp0Sf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270074


On Mon, 26 Jan 2026 17:42:09 +0800, Xuewen Yan wrote:
> There was a lockdep warning in sprd_gpio:
> 
> [    6.258269][T329@C6] [ BUG: Invalid wait context ]
> [    6.258270][T329@C6] 6.18.0-android17-0-g30527ad7aaae-ab00009-4k #1 Tainted: G        W  OE
> [    6.258272][T329@C6] -----------------------------
> [    6.258273][T329@C6] modprobe/329 is trying to lock:
> [    6.258275][T329@C6] ffffff8081c91690 (&sprd_gpio->lock){....}-{3:3}, at: sprd_gpio_irq_unmask+0x4c/0xa4 [gpio_sprd]
> [    6.258282][T329@C6] other info that might help us debug this:
> [    6.258283][T329@C6] context-{5:5}
> [    6.258285][T329@C6] 3 locks held by modprobe/329:
> [    6.258286][T329@C6]  #0: ffffff808baca108 (&dev->mutex){....}-{4:4}, at: __driver_attach+0xc4/0x204
> [    6.258295][T329@C6]  #1: ffffff80965e7240 (request_class#4){+.+.}-{4:4}, at: __setup_irq+0x1cc/0x82c
> [    6.258304][T329@C6]  #2: ffffff80965e70c8 (lock_class#4){....}-{2:2}, at: __setup_irq+0x21c/0x82c
> [    6.258313][T329@C6] stack backtrace:
> [    6.258314][T329@C6] CPU: 6 UID: 0 PID: 329 Comm: modprobe Tainted: G        W  OE       6.18.0-android17-0-g30527ad7aaae-ab00009-4k #1 PREEMPT  3ad5b0f45741a16e5838da790706e16ceb6717df
> [    6.258316][T329@C6] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [    6.258317][T329@C6] Hardware name: Unisoc UMS9632-base Board (DT)
> [    6.258318][T329@C6] Call trace:
> [    6.258318][T329@C6]  show_stack+0x20/0x30 (C)
> [    6.258321][T329@C6]  __dump_stack+0x28/0x3c
> [    6.258324][T329@C6]  dump_stack_lvl+0xac/0xf0
> [    6.258326][T329@C6]  dump_stack+0x18/0x3c
> [    6.258329][T329@C6]  __lock_acquire+0x824/0x2c28
> [    6.258331][T329@C6]  lock_acquire+0x148/0x2cc
> [    6.258333][T329@C6]  _raw_spin_lock_irqsave+0x6c/0xb4
> [    6.258334][T329@C6]  sprd_gpio_irq_unmask+0x4c/0xa4 [gpio_sprd 814535e93c6d8e0853c45c02eab0fa88a9da6487]
> [    6.258337][T329@C6]  irq_startup+0x238/0x350
> [    6.258340][T329@C6]  __setup_irq+0x504/0x82c
> [    6.258342][T329@C6]  request_threaded_irq+0x118/0x184
> [    6.258344][T329@C6]  devm_request_threaded_irq+0x94/0x120
> [    6.258347][T329@C6]  sc8546_init_irq+0x114/0x170 [sc8546_charger 223586ccafc27439f7db4f95b0c8e6e882349a99]
> [    6.258352][T329@C6]  sc8546_charger_probe+0x53c/0x5a0 [sc8546_charger 223586ccafc27439f7db4f95b0c8e6e882349a99]
> [    6.258358][T329@C6]  i2c_device_probe+0x2c8/0x350
> [    6.258361][T329@C6]  really_probe+0x1a8/0x46c
> [    6.258363][T329@C6]  __driver_probe_device+0xa4/0x10c
> [    6.258366][T329@C6]  driver_probe_device+0x44/0x1b4
> [    6.258369][T329@C6]  __driver_attach+0xd0/0x204
> [    6.258371][T329@C6]  bus_for_each_dev+0x10c/0x168
> [    6.258373][T329@C6]  driver_attach+0x2c/0x3c
> [    6.258376][T329@C6]  bus_add_driver+0x154/0x29c
> [    6.258378][T329@C6]  driver_register+0x70/0x10c
> [    6.258381][T329@C6]  i2c_register_driver+0x48/0xc8
> [    6.258384][T329@C6]  init_module+0x28/0xfd8 [sc8546_charger 223586ccafc27439f7db4f95b0c8e6e882349a99]
> [    6.258389][T329@C6]  do_one_initcall+0x128/0x42c
> [    6.258392][T329@C6]  do_init_module+0x60/0x254
> [    6.258395][T329@C6]  load_module+0x1054/0x1220
> [    6.258397][T329@C6]  __arm64_sys_finit_module+0x240/0x35c
> [    6.258400][T329@C6]  invoke_syscall+0x60/0xec
> [    6.258402][T329@C6]  el0_svc_common+0xb0/0xe4
> [    6.258405][T329@C6]  do_el0_svc+0x24/0x30
> [    6.258407][T329@C6]  el0_svc+0x54/0x1c4
> [    6.258409][T329@C6]  el0t_64_sync_handler+0x68/0xdc
> [    6.258411][T329@C6]  el0t_64_sync+0x1c4/0x1c8
> 
> [...]

Applied, thanks!

[1/1] gpio: sprd: Change sprd_gpio lock to raw_spin_lock
      commit: 62c7b1d6aa8b287c7554dd9abd3503fe4883e50e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
