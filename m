Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897046;
	b=ff3mN7UmXatVGbFaCPF7mdnccFQJT1sAcw7rIxKV+rRi4ZDzPrKRe1VKNpemXlSG6YBh
	 amecLxwfZFQH+vn7bKZUuhJeJpVsRyooMP5bfUvwFVBnCnaJhL/NJome+SRWbwA8xG0kl
	 7bQLxv+YYevoYA2FrQkmACMot4ktXJWG8b8ZMMxS6WYSrwYpLp3eiFGRgv85zhceB1G3r
	 1Y7Fw+VV+cYzbX+oN8aDeOHmHcmA0nwKJ1ckkdhrsFhJPl9M77Uu4TdDtzQl1eqNd3N45
	 5987IaTqd1U5BnL9kRVGspc09jlY3/S6rtk2Mm2whnlXqSYcLr2MUtxh23gVUTs2uGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Xa99gepi22SogAWQPeAgc0EROoR0OAvZegPBJ3DWXuQ=;
	b=EtA/OyGEn34hZ2bAEBeNACrVmkS/eeWV0A6y4PiB6mhFa+ZaVjmJDEJAEc90pYTc8r6D
	 i18lTDhdEN9SpWoYSpyTyjED5EYP3mWu3e3QN5+a7vlaK/N93XRV6/91yf3MV75X2SwUN
	 RDw2Jj05K+aCkl+4O+sY0/h4T/owPfs+1yiXKGWzV9XfZxMRxlypatDlBkO4Serx0cfbn
	 vKtJGcLzAQiREO7HrCsFfjR0ylkBxlpvvvDgnGG+P/SH/+Xm3C+ATLXqrihsvjGPuMBfL
	 77l0P03wflfcH+T1733GIT2+0ygzm0kfZpGPSYx5JlwLKkhIzKS21vRKbot5Tum5sQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rgXohnzV;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C116606A32F
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 16:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C116606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rgXohnzV
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1766404f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897044; x=1794501844; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xa99gepi22SogAWQPeAgc0EROoR0OAvZegPBJ3DWXuQ=;
        b=rgXohnzVDZmKWDgtPxz+lqRsMWzijqktyxzGAAmMGj1KC7dBJql/AXViWM9sEX09Jt
         0zctHujSqEUdvyDhCbl3CoYD4WHAmYIns0aToiMsUi+jiRaX8i0C3O01cqorLYdxLkT/
         9jO8ElU+VpvAGDw+7sykw3AKFpNAIHsCJ+HXVersCqyIfBWe9Z/awLH4+Vn5QTkxIbxJ
         GqZdttUISbDbvRgA1DsUAihFg9J0zhitfeCN4Yvvdup6NuizysqZnbXq+3/DIXVbpkiu
         wJMsjIacdXLaDZAdZSkiUzpygFXKY4LWeFRuDYYxf0mWQQ7XNiiZn7lQRrwQxrVquYvy
         AE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897044; x=1794501844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xa99gepi22SogAWQPeAgc0EROoR0OAvZegPBJ3DWXuQ=;
        b=qzqFAHevm7HpgBNDukQes77D0ehVm7iKjwPnROyn9dZsBOG8Hq+W2Z1BsVIGdxCEtN
         u0C35ckdEGD4o3v97+ZUZH0J5baxc78xOjMpc64kbUU6ZyhWZfDDrJQsjV9SbRD5FHOX
         6iDR3VLuZ7FQSjBkzZDGVCQCscLAMOcrmt2NXQ7qShZquSLLAnEqmFm4A9FmtYdvmyms
         uXzbBgg/gjjgKumlxkzrjYlFVZQ8u0jTJJYflOcQ0DdzTDETSurzCfEPgIQC7nlVFnzD
         mV2uZGhYFOPqMnUcUolhQ8AuzRjK8WD6MEKw3uwmQTGEgsgoIEe5q49vhN+XLzo/VHOw
         eaDg==
X-Forwarded-Encrypted: i=1; AKwUvBzdpfOL/fHqivHH/GGx9EBv40ZNLswZkFyPQD/EAMRu5jLJPiLRmZsDYKG7KnJKsAwImrdEFuNWlQGUrx840A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Ju/1jsUg0l1gElxB6Un9Q7wlD6F/0fUpWxOvTY5UOL0JiNsE4
	OAXFucpjExEPiY0D2akV3XZoxZQ7KcnWIV+4VRoLKgakJ7daDHmPK9Ez
X-Gm-Gg: AYBFou1T+PKSGqiK926XSxYxJ3+nb+n/9bYC4tgP4Ts5g3xOc8W7hM2xrHtQsiBmrDE
	crflmhv6u67j0qP1jzShVrGRVvBESka0gX+GwfDJlTfGsXN6cyF5y+uNnrr+TRrkEujkn3Hee9x
	z5qDr8IUakNBw0AH6ke+kcZiPCkW/b9Q4QeAXIzwFDIozqsKCv7NI33E9nudyh3rWOV4je0i/Y3
	VE/yxoDoY9QFcIR3zBLrZN8s8//LXfP59eeCysvnxjSlwO4ZaB+0dYBy6yD+rHKuXsvn6cMy7dd
	PEtFNui5pA0fDLmGDkgu2KyWH/YISE1X06tgaffzah92Vjfi+xV7i+nc6Damop7NXt+eqMQnosH
	3YallLrLdDeKKIeOMMI+Lsv0+hYJAbur3IXjNrXBvXrF2HMAJKaUnChLz27Y3LKCA+CYV7AYDJg
	Pqi+9MG+8EwGP+/NkhOYi5LQ6iz6An7slZu8DRW852M1O4kLAywRUSYgpMKwo7Hv+/2p8IJYG3F
	qYGapvlNU+ew6BJMfhBG0RYCwu+e51lqviaXx/KshWDPkBsTeSx7a37PjJDPMRXs66rof9+fGYr
	HId4QmuMB71vxd0vrTO6Rx6Pt2oluPwNehjvDJKZEE3CxYofgVTzsKpwZOWW8HrOrLu2lGPVMto
	Gk3UxZIgihmaSZ1OHPX1nbTTqWFN/
X-Received: by 2002:a5d:64c6:0:b0:48e:4e00:b737 with SMTP id ffacd0b85a97d-492775f151amr306112f8f.54.1793897044130;
        Thu, 05 Nov 2026 08:44:04 -0800 (PST)
Received: from andreayoga.localdomain ([151.43.242.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm11441519f8f.6.2026.11.05.08.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:44:03 -0800 (PST)
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
Date: Thu,  5 Nov 2026 17:43:55 +0100
Message-ID: <20261105164356.28913-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104211207.1392343-20-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com> <20261104211207.1392343-20-mathieu.desnoyers@efficios.com>
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

On Wed, Nov 04, 2026 at 04:12:05PM -0500, Mathieu Desnoyers wrote:
> The retry of the policy check in __sched_setscheduler() drops
> cpuset_mutex and leaves cpuset_locked saying it is held:

[...]

> Clear the flag with the lock.
>
> Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Hi Mathieu,

This is the same fix as [1], posted on Nov 2 and reviewed by Waiman,
Kayra and Juri.  If [1] goes in first, this patch can be dropped when
rebasing.

[1] https://lore.kernel.org/20261102134606.242743-1-parri.andrea@gmail.com/

Thanks,
  Andrea
