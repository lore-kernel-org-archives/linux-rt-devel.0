Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346738AC72
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881581; cv=none; b=pVU+J2OH8F6fIRNGnXKz3sC/GTsGE5VV+griTSbacEEQmfge5LnOaoqauIjRpzdDw3RHBiuUH/Ov2zSGvvTV0Wf9l1R0ynXvbE0JKYLErPi3mWkHN072xwuKErv1hseOIQpgXH4I+VN7UiUpHq413iCbkdAIXQ3P2qI8Ewflnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881581; c=relaxed/simple;
	bh=zqzp6N+tteerZ43Wplk3qf9bDZUdzAlltR13R+ntqsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vgqn34RyYX1Zwqg/2S5gc9PGZwmct8pZOrxQcUFXIlGAG86KCmuHift74RiBhXcaYq+2/scU0b5eH2xjZeDOJiMND/6/33pIZw7Bu8O7SM8+gsn/ePW4ZOyXgNpEd1zVSnFbDfUmaAlImkLZsZ5JsutPfr2acdc0QIWVAlfPp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhAtYxAI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhAtYxAI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad21f437eeso38120065ad.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 11:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776881580; x=1777486380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvJb0BsWSnyMQEp11ZDn/hO/2BNVrzmyvEY81XwYvWc=;
        b=YhAtYxAInVymX5T16fXP27H8K/popydmQVW2ZMoMZv4SjRA/DcQNu0zGsPswzbusPE
         kvQvzaFhgAUCW8wzX395gCUMy/c4OjIT1L5HYNUINgOqtYVk0IJFrb64M/nS9Jgu7XMc
         ojL356j4oz+AEIdePFlbttr8QNFBMg91UlQ434/RPyh8n/rHbwEy+RTFwJwyocW2ZU3v
         jytEiEvB8q3vxZ4iDfvAauOcb5wKbfSTri7sG46mTwkYtN4FKtlKBe7Nozaf/zQl8i0B
         ACl1vJkhWGBV4h/yEdQKycha5WbN/1Dj1oEP1H0dJ6F9fp97Vb64DpWjqMKxcHIlzIBG
         EUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881580; x=1777486380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvJb0BsWSnyMQEp11ZDn/hO/2BNVrzmyvEY81XwYvWc=;
        b=LKMbAjIju0PCtuTqW7S661/ug5wlpuSQisDsmeNbNdSv3a/vVmec30Uf0BdpTlYNpy
         0VWe6y5GRdHfjDBwxMRKN5YN8y5Bha1SLEvkWbFteemmI29RDFPONS2N1z/gnmCOgVy/
         v0GU+0PwGade4V4El+zjXvUmybbp38oXUuqZrbW5X+2aFLkiHQ7wBCSa6IeX64f5C+un
         KhlQaLgSKazC53VtCp5G5d7wUXGHLCnIwn6PiiuY61jxn/6tGAZS5sxOHVppI4UM0Ns4
         ncRwSESU21tukrokTG7kLkyyF7RLZ+Vm/gYnB3dOf3pzTIRq0mNXYTRgiakRN8aFtStI
         dM0A==
X-Forwarded-Encrypted: i=1; AFNElJ985tyoQYNUZpHjT91ZKItxofB332b1KJLtLexYYHeb5JZzGqy5x3KOa7yIqEbsAwA269vy7KorkBQpHQWd8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcfcT7SNxL2z+27FTJPxVS4MUbCzKIC7/X49xxiheQkas4eFjP
	TZaCq41zdrrdjV9KN8J5zv6TiMG1CVHpEztF0yrtWiFCh5iCIAMoLyJM
X-Gm-Gg: AeBDieuWXFlVI0FRmB8d3TJoUFtKUZtEoj045Z/WwdZ5Z7G+OrI4bheoVHUarbR1MBk
	s7IQ/bQKYYO/p9ylTY5h4xm0796lLxyQRpTItzMiGCEmpN2uU+gxx46Ldnl5cDc1atoT7HIdrYJ
	Sn130SCRTqQWLs/U2IzBF2IX6Jy0/AVdYoMuArCrssc+eB/EFc8fr5e2fie4bWTSsGUd4bOc+1C
	5NRF139hHW4x2wnGcDhd5y8Ws9q+AGic46EnWwBFPByKGPOUCadny295m60Y4L8tAiDrM5hnZiX
	DM1yf2T50d3jiKTop4ReIjP8V4ZMNxQwVxknVJt1+9Vz+KXmZ/t0qvbqWKelixH11Ffn+rFUIQY
	/IaTG8fndHaKX3zUI5mU5lcaoydqAtvO2G+4F+ge4HfOC8LX3pMMMyGzqbJpeZQIaT1NwNXxUWx
	N1WZAfp58mzCa6hNe3aq/YIvejd4S6J2dZSPlBF/F9mFXaD55/6agKgcK4F9hRoAC2MyYYwArYr
	WbbfA==
X-Received: by 2002:a17:902:e748:b0:2b4:5d0c:7a85 with SMTP id d9443c01a7336-2b5f9dbcd42mr221249815ad.3.1776881579714;
        Wed, 22 Apr 2026 11:12:59 -0700 (PDT)
Received: from lenovo.localdomain (211-23-53-87.hinet-ip.hinet.net. [211.23.53.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff713sm173734745ad.5.2026.04.22.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:12:59 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on PREEMPT_RT
Date: Thu, 23 Apr 2026 02:12:46 +0800
Message-ID: <20260422181246.1944073-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422142325.Glnd_2Zc@linutronix.de>
References: <20260422142325.Glnd_2Zc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Apr 22, 2026 at 04:23:25PM +0200, Sebastian Andrzej Siewior wrote:
> As elaborated above, this is not PREEMPT_RT specific but preemptible
> TREE RCU.

You're right. Sent v3 that clarifies the scope (preemptible RCU in
general, not only PREEMPT_RT).

> If both this then use this then I guess something like
>     lockdep_assert_in_rcu_read_lock()
> is what you look for.

Adopted in v3 - thanks for the pointer, it reads much cleaner than
RCU_LOCKDEP_WARN().

v3: https://lore.kernel.org/ath12k/20260422180814.1938317-1-asas1asas200@gmail.com/

Thanks,
Yu-Hsiang
