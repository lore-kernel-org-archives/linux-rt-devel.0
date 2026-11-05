Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908323;
	b=XJ94bdKdc9hnx3YM2eyJdPLxQ8hrX3+FiW+6zfgZ6cotF+qn9IkU+mEUMO4v19tfBagV
	 fMUkfvoiDqw3pxwOnGMSvdaP8b3meu38uBhwmaJFU80oFxs63Mz3D/vbwsIhESSsd7O9Z
	 H0AS2qegrn5HcuEOem3iX2E2h+a8ZQl/X7JHPqCQVjAMlAaZOkmgxdogIGD7a31Woc9dn
	 8L7LuGCJsKflkzBNDvchWoBnHiaPSky/mBuQChLBhOoNQ4du8ESI3gMzTkw5xhst6Y5nm
	 r5qW64SIkC5WGG0hrnCvYw/ctHL20qdpjieUTtr+R383VfalPmGGXKGbn41zmHvHMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E9t5hHnAag1EnA1IvHhWRwDHScTDeDJAqRJADEROHAM=;
	b=MrbM0KBTcuqRYD+mX1ud7IYl0FjNYS4Veru/TD3iKlixt0H7jkwpktJ24DwreR3PbZ/8
	 zDS97YaAAxMV4/GdIjTqfu9Nz0ud6eexYkQMSQ0vv5N4hIIhgMSdfoqP66d9E/dJGm4ld
	 yVLnT4tU3iZyOhb7X/i8sorbXWEluCph9ejtSEW7AosPelxbSwFKSqBk13XSCGHgQIoly
	 CtuFMTnoDL5ykIouOkLpgGs+fT5C5ze3K7JSTSWe/NT1341OyyFsBWGYCWB5cixoVr5C4
	 Ijb9GESG/Et0KN+J3l17s5dsvg08oGOF/bbfzbXAOK1fJLAYYfIiFXtL2bmT4Ku6EGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L081DH7a;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D81606A33E
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 19:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D81606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L081DH7a
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so2766295e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 11:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793908322; x=1794513122; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E9t5hHnAag1EnA1IvHhWRwDHScTDeDJAqRJADEROHAM=;
        b=L081DH7aT/aiq2I70MG+n3JBbTd4FjwEIWnD9UcBf6PQg504pNtYfCZ8XsIVqdYqTy
         41nqSWG5wbznRB6T+kVRgawWOmYS50w9aE1Qag+aa8ouTa1P7PvLL9ml7Ov8JmZRJpnf
         dKDXSG35UGyy8ceoV+eUTbvUA8dao0ZNsHIbMV4Pa778QBjOFd0oHqQl25rFWc1tutaY
         7YqA0s1sNryVv6R0VnKgS2Ahz4ivmi80K14g5socPFsd+By6QBaW3pNqRQjI9uRz99P7
         1l07Pdd0mMsMoTZJhHMWP+GSVW57LXJSuikpI9EiyfECbQrtfZ3Nc8EekUNH89zgCQf9
         trVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793908322; x=1794513122;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9t5hHnAag1EnA1IvHhWRwDHScTDeDJAqRJADEROHAM=;
        b=RWj6rtgVe2osTKzu1fOfuVH8LCn7WpfG/uXJPS70xgqRvMI/7jl40xecvDfrRt+TqS
         G+iAm+nEzrl1JDaTZU5WOnm65nv0q4CnmSOY/t7Crp8RHcGSPP1zAay9ChPOdvmsazPF
         J7XdnycR80bHN9cCYHqxoPUyTfv4BahcmMilK5bswqpvwTCb8NLqj3K5xW+LyavFBifI
         ZlFTsEH2IRtuoR/R6tSfp0hBt6dI886nKlJa860XswAVjUpFuAEnaxBTHn+yxWrjWtnu
         MnobgsCX4xhkRDxr/bRDNWcI63P0G0yCT/PPDIqmj53XzXw4NcEkyznKy4nIeTb/e4HD
         KfvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxM8Nvdwa0P5WULPoMOyJ8mJVEOf0YQZINZJ/ER0FUD6eWSJTK98x5IwJwuV3bB8c8Mz3aQetMvbcaBqUKXJQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9xOCSC2nCiXxr82f3X9ZML2eM6UEBj71atzkFDeG9QG+FAVrxT
	o1CDtCW6z6Dm9T+DXoXxWeeU60ERC1q25yM2Q84NHVLl6XbgUJ3HxBry
X-Gm-Gg: AYBFou2hQPQfRspoaSuJQf2IIbRwZbVGCUpjpHb/ZqxLjLtcP9DsvPjO2hrGIbI9/T9
	PdZEOhpSFjJO3nEYp/9B+CV5P73qnwlsuoRTj5FS8oZaNr8A6Cg/VlyImJUkvIvDIkagh/4UWdO
	yxgYjlnJH57vv1BssWtDoYGBK4nP9Wsgj/pACcMGkL1fXJj5+YLEDyUGPk6qraFyLN+yAKAL6Q+
	ZZljqH6Ivt35sBE4MjssO4iVieuuKG5opMRXDdgrfXTJkB8Hd8WY5om4qdg0PaHOxV+DfsVTJWj
	AJDzuoeXPv/FQghcnStS99J1qQ6bKhi0cKzf/miNF4A3s42VKNRuRIzkNz3AMLR3EiH3FnDxoCP
	cIAHKZKw/FnQNn9yFc9ZZWTGJucct4QvK4VMCI9nipuRtvbD5zUiyu9mBBwFXZ0NzExdm28LSRO
	fH5AWHe4BAAIwljxDBMlSO8ZBiOX3u9lqHgDRQobpXWoXTfFO7LAEZIKsAcKia3azx6ze/mB+2c
	mit/me96k0sWQmSK6nOQJsU2+7/9pJQ3QrE3b6zNKQ2GZTJxcZGc+SFENLOWIxZL1f0LTcm2y41
	OUx37qt0EptTZEujfFDN9t9tB/ul2v7CYohc97ttdavt4mbCcQ==
X-Received: by 2002:a05:600c:6d8f:b0:4b6:2242:d0be with SMTP id 5b1f17b1804b1-4b6d82b2c85mr3060825e9.0.1793908321669;
        Thu, 05 Nov 2026 11:52:01 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6e1b5d676sm2497515e9.7.2026.11.05.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:52:01 -0800 (PST)
Date: Thu, 5 Nov 2026 22:51:57 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it, mathieu.poirier@linaro.org, 
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	parri.andrea@gmail.com, m.szyprowski@samsung.com, weihengqiuu@gmail.com, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 01/24] sched: Fix cpuset_mutex double unlock in
 __sched_setscheduler()
Message-ID: <auzdzi_ZIqmYFV-Z@scheduler.schedules>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-2-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105193359.1450487-2-mathieu.desnoyers@efficios.com>

On Thu, Nov 05, 2026 at 02:33:36PM -0500, Mathieu Desnoyers wrote:
> From: Andrea Parri <parri.andrea@gmail.com>

> Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

You gotta add your own SoB, no?


Cheers,

Kayra
