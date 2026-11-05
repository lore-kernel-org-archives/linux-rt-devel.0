Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899757;
	b=Czj3ymADt7NvTyfNtsuHDu3S7b8//YqrXlkpn3/IntVmddkIZdxq++HJOeZbg7PJ0J81
	 FnhbapjpjQMD8KVCe8/oJFB+hFfM4q2EyYXIQSUNrQJgLFddvcKvDSGzASsiBmn2qHBmZ
	 rmXJ4g61982mj/LtxxLbfFRtS+ADhaodRgxSEmMpvUJ0ZbkfqOl1QSE/MJWAryHwPo+WM
	 yvh5ggw/qWZm6hXghRN93MmVYom60tmaCsy83O4lmhq+UAGABqX4MrtcU8MNfPL/PJe8L
	 2dEmy/p/E1szVoq1/lYLlo2qpQPh8QuSFKmc75cjvGl6UABp2ppKu1Wf/Nt9/BmsUhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1OnqzRsvitQ4MyI4f27p0X1rJF88pgVycPeFzHfgJT8=;
	b=YL446GVAqOLIKYUE9GRAIKknWgnw1dtxynWRTqr4m9YE9c9uhDZfxdqo9k2TUyKegKeV
	 E/pkJtgp1fbeuTO2DTSNCjzwgD5pzfEERm8q1UY7ShJtHIjT2MTDf7GgdnwVaFjKPW4Xj
	 dqpIPAh4+MephfbKyEo/7Vh9uHquCDWxqfwEaUzKZ3R4oLNH+rucSw/m/QDTvdFoumdbb
	 ZLIHLzMiTU8HpBfYpFroslK5HQtAMZG7TYTHfJAEDNjz5zLN+jEmSAq6cli3aB8IWVPe4
	 Jc5Al2k4sxHBJ5bubc9Z/ApV4YxzCPyQ2P4QybpJ/V/A/Nfp7G26jhsA33ePUwZosyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wqq5O9fR;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E8606D801
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 17:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C29E8606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wqq5O9fR
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so20097075e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 09:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793899755; x=1794504555; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1OnqzRsvitQ4MyI4f27p0X1rJF88pgVycPeFzHfgJT8=;
        b=Wqq5O9fRTqIecTXgrQyd28oGsy4+mJsBZxUjqZb6D9HJ2XRtFovUR2wBdjkfRYoJ5B
         l8t5Wj8X0OSOeX4K4zfwScq7LF7ES7FB4uA5bNdP6bm0Jht8eZ1jX+DRpZwXdFiFCIEE
         miJU0nGWyhlkvWSwH/zsJCyrXQGSUo7SGsSAJQdrlofa34cBtKElPEChbG4vXTsbWNw1
         5ClK/U82LyE/KkJRILwIaf7WpGZHAr0MMOOlHRwxorM4GtXx/DLnBqC3alH24g5eWlYp
         UMlUBqE1rTdtrAxjabYoUSIJUdPaxp4qljuEs6+jCankfdqTW3UVUtAWHTGxHsW/ZZr6
         jQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793899755; x=1794504555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1OnqzRsvitQ4MyI4f27p0X1rJF88pgVycPeFzHfgJT8=;
        b=s918wGYtE+deDBPpSQvOn6m/x/fsZDKzOtYEkdOmFB/QPeKWLzBqqG0noKhGodHpYR
         vQ1XE2ptafQEsBZ94YZt+EsJWmEYh5uBDz4swDfQsARW2hJs4Z2ZKLWbr8uhJgQWC5lw
         giFU9UVolCSTLcSSKSY7QvbZgVhX10S4Ghd4T0+AYSxMamATwYEL1Muc7X5s9orMfydt
         FUCYmqO5n2lzpsauoZ1RUKQ9P2ABmwH1U0OC30N1KduuFhnBuLhOasPQ9DF0v4ggziCs
         VR2pI4IHESiyEPtpOOBnFdJ10rSb6ijbnfkWmXFHZPkwBS2h+0uJDuyyTA9ecVvEWYK1
         IkSg==
X-Forwarded-Encrypted: i=1; AKwUvBwQ7bwWWWjl42JQfEoH2RbKQB7nMgzCGId/yOo5SvUSNCSqtWGTtvQQ0r6cIrQ09+rzujrA/KrdK+hug2i3VA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/lfX2poVkoR0DX20ABSShby7Vqhl+Fnwi5XBaLl2jsW8AjlBwB
	R3REM80bInK48bxGmoQwHyZx5PULnkpRZTaNUn0Ryqerxt/WY2q5C8bM
X-Gm-Gg: AYBFou0k7fgloXcn7rVXEI+mnt06EjrsmlOYYCRUMlhq2wtAxsM4mv9MnHgUp/9AUaV
	/4MBt1zFrqAUOP7D7EScTjFFsXsGsYMm5haYTgAFp2qMBS5ChKLv2dS0Ra+lErdfYAA8zLB6Kiu
	eigvTu7xMxSE01KYDDWHy0QJAY+7lL9m66PMmwDnUBFSEdKjmuR6iGoYwypE285cUtlxaWoM/UK
	2AIwtEkdniVVJn2CBhRk19JjA1nhC316w69zwgaUst6+BHgNecEz/1ZzuRdkd4DVGWUrnFwkSEk
	fWoK3LnIQnIFBl99oU+vfz48S/iN1zc/JNoieBOGF4eTfBYHre3OwBFc7Sh9KSlbFYOR8kB7Cv0
	Q4nI/ChfFJTYHA59Fy1H0YHrtlUBik1r8qIX2pIB84FgHuAlfBrWn8kIxeMZPtwQHfmFonvMsX5
	XztHSo4x4zKTXcm3fFYx7E3UbzgwnfsxGbQfdYnvyeFUMMwUIrJteiElm6z+dZX3hBD7jEnltFZ
	miml6wbGUHc/itEnKfky4rrtExRMLyp0fQWPraeqIuX5eNPpAgG10ZB+H8j4pQZatZ6yT3jLsko
	7a4Iq5cWFiEApzHQKwPn8Kd0sv/h/l3tdQhB05+wOV6NY7tHwVt+C3F0zb2XVb18KSBy57KFT11
	7mllzh78=
X-Received: by 2002:a05:600c:3b29:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4ac17d19aeamr401115205e9.21.1793899755121;
        Thu, 05 Nov 2026 09:29:15 -0800 (PST)
Received: from andreayoga.localdomain ([151.43.242.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae72dsm131080675e9.3.2026.11.05.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:29:14 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Kayra Cizmeci <kayracizmeci@gmail.com>,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 19/21] sched: Clear cpuset_locked where the policy check retries
Date: Thu,  5 Nov 2026 18:28:58 +0100
Message-ID: <20261105172900.38029-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a63396b0-9b0c-4d4b-9754-f503cdb84098@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com> <20261104211207.1392343-20-mathieu.desnoyers@efficios.com> <20261105164356.28913-1-parri.andrea@gmail.com> <a63396b0-9b0c-4d4b-9754-f503cdb84098@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 05, 2026 at 12:08:50PM -0500, Mathieu Desnoyers wrote:

[...]

> Thanks for pointing this out! I'll pick the preexisting patch into my
> series instead for v3 if that's OK. Then maintainers can feel free to
> pick it up from whatever route they prefer.

Fine with me, thanks.  Please keep it unchanged, with its tags, and
ahead of dl_accounting_unlock() if you can, so it still backports
cleanly.

Thanks,
  Andrea
