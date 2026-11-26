Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693960;
	b=UYtE7akEEyfxcckt/sGIRs1aM6wTrCDUxWf1wJovES1UUVOtsAb13t9SpVTN9CBTj5lG
	 wKm127mR0iqjhm+oM626cw29WzEFqQId5E8xmqzUxOXpycpQF0ZTo57oBKjfxEQGclPE7
	 wJ9phczMJHu6yxHkmiYwjow+bnCr3bcOAoA82kPQ/zTKe+kgP9xjzvVTyaOcUfcAJ/jsi
	 tmRG3fiUQ0r5w6tumQsS8sESJCqnz1R8Ou4PulMRXvwPMJbzsS1nFTUuefe7OmUHF3aaf
	 DY13NRLKEBBZ8rN9qncphr+D3bt1c6JRhSIIjCqpQodroRLtg7qEWVYO9PjeK71L/mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jz3Gl0iMuNeLWn97inBKvNEHHQ8P8yZhhufhRbL7IZA=;
	b=E7zP0JytbRAFodzbto64RBiv5Lgco2fQjbYKWHqEfyaOE9VIFH5nUHnrhORV4QT0xnJi
	 rt/et+d0XRztFhtzSQXlPQjazQ9O7CMUr9Ev2MUxQlWAnqg99s8GDaVQ1aF/dt66moNrl
	 y4u3aosGBJpNi1eBP7wlhUQuEixuY/LFM3O6hUeDQW/Cw5GB6Uo2g6GKH26A8FUm82Htc
	 BwonekSKgVJb/Lk93Ngn4Z0WlN/FIEqvSnwjwGBCCNU9XtADSpIY0OQVzhH3U5/MkBOO5
	 60pfjNAv0t46XsCEH5r0L65rhXXudDL/5mnce+JPptORkxzPQ5E+6KfWKcVO0OVfemA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0+VuWNq;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C4606A321
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 11:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 364C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0+VuWNq
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2f0c72f9a1fso16642455ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 03:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795693959; x=1796298759; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jz3Gl0iMuNeLWn97inBKvNEHHQ8P8yZhhufhRbL7IZA=;
        b=W0+VuWNqtc5g368JFip8K4eiquswnrp97Yw/04V16mvNvPD9M8Q/LhKowcLo+Qu1Iy
         C7vXJyNHztyDOUUK72e72p7InN2iNozBqgH0S+BA9fypooqr8p1R5aLoT1uy3xtp4zpx
         GIuAgcePGfwiVRtUAmfRxy00mMdjL4X69ND3uE/0N2V/CpvFoFDz0A0MU6OScyAyO5ZM
         fuCRT5ixnFL6EthBkGUXn3VuKdnOrXkCASyUvsd332MjsttkCR5U62FvqQh0qlWZCA12
         7WGQRuIgkpgQv/gWns+OtVIeXGLZGJ1xlBMkGPL5lxY+NHE9r0OqBlHZ+SQC+09BU7bT
         7rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693959; x=1796298759;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jz3Gl0iMuNeLWn97inBKvNEHHQ8P8yZhhufhRbL7IZA=;
        b=Qh2pXdUtl7b83r799MNV0lZIxqSKbZihNXtKzHBGhAtRs3co7R5lIBXWg5yhBfBwV5
         WyA5Oxo8r3h5v4Hs8rqIu8Ab1cPnRQelPLr7isR61xClZZwaZ9McoVliZ2N3uDcgYBVB
         HoqcSxWmBynYiPvlZUrienTN5ycB3dnkuYPkiMrpB8itD9eLnl/FGpXHOE2B3MLSr55i
         g757u99CBkaTDHhYl8BrVpjQWjHyS60bJLwQZKkwXH6rGbK3OQZmKJU6mDay2JhwnvkJ
         lJUhHpEDcsu5xt1mPvpDCavrqrhRarChpKhIqMTF0GGOQakrv8QwXhTheTpoF1vsn12Q
         TMdg==
X-Forwarded-Encrypted: i=1; AL+hErGaEW+sI+iK4B5mmCue4RYsdJ7S6fowyNfzuLJ9RDXDH4kOHJRLqsu2MgZCsDRRyLTEHQPGs810MEEm/1O+Ng==@lists.linux.dev
X-Gm-Message-State: APuU4Z8009q4RyzRKt4dPMD3uR0W2uXPUnjXLf148kr8tegv+iBWFtV4
	hr9Rjqh632MQenwcbMinIgZCwON1U6HdZoBWypwxmlJVOVjlFNhXzztt
X-Gm-Gg: AZFdTZdTYhJB/jl2gZWSi1WRyf1X/CRQmK+zvCWO3qyHZ3KBxprhn7R9faPT+tkb2O3
	4YAHXsgru/uQ6fTcrNNMhWiG+b34K/3ibtkHX4E4ccPzs9jdfQs6IiF9QDWCat4QhWKqMHFA0/Z
	KZdQ9lhzALfzuqDG7sVF4J3s0raxTsACaQV0pDgBWYRz7xeVfmwj/VkWfssdxk+Xm36HkapzXmv
	2yKyaWF9md6kuREtENgdVPYrHJ5qAgW+wMR8+L4XNPt6vlUmPuyhfa6CcfARG6LvkT7VaCdQBbr
	O7f+svGlEum6LeM3wu40vfe4q2Q8YHWqtXU9ZEwmkYyF4LOltd7HW3YvgYk6kDq3/Gf9xpi57Ed
	MeyihwiwntR5HdYlakn++0en2mbWJEqnuzKhiYXwm6LAFM21KNp3D8BbNJIjHKEDHSou0jimlEW
	NcqgBBlIioMV7QtemQixVKGrkYivaElJsl0ZpJ9NAdgiOTTN1/wUYr+qYktKeyqQgj2/jfwB85f
	eX9kARri1UbQz9gNh795+Qy2Xjm5lnQj8kZf4DTcBhEPu/cSsRd+l1BWLpgnQHREUIrxvb4/8sc
	pBubnG/bkMyuQ5Vo6+HyLb9atw==
X-Received: by 2002:a17:903:1c3:b0:2f0:41c7:9a3c with SMTP id d9443c01a7336-2f041c7b2ebmr213510435ad.8.1795693959476;
        Thu, 26 Nov 2026 03:52:39 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:61d:93ac:f2c5:2564])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f191464sm105486475ad.1.2026.11.26.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:52:38 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: bigeasy@linutronix.de
Cc: frederic@kernel.org,
	darwi@linutronix.de,
	john.ogness@linutronix.de,
	linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	wagi@monom.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org,
	Zixin Wang <w1355457260@gmail.com>
Subject: Re: [PATCH v6] Documentation: real-time: Add runtime tuning guide
Date: Thu, 26 Nov 2026 11:52:26 +0000
Message-ID: <20261126115226.617382-1-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125150114.eWhmDZrv@linutronix.de>
References: <20261125074658.33117-1-w1355457260@gmail.com> <awbgq0xQyJATel0_@localhost.localdomain> <20261125150114.eWhmDZrv@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

On 2026-11-25 15:01, Sebastian Andrzej Siewior wrote:
> This is pointless. The enqueue-to-invocation latency is meaningless. If
> you have a RT task which preempts another task in its RCU-read section
> then the grace period (and the invocation of all callbacks) will be
> delayed until that RT task is done. Either way, even with things like
> RCU-LAZY the callbacks can be delayed even further. That is fine.
> Nothing really should rely on the callback execution.
>
> The important part would be time spent in call_rcu(). And the latency
> observed by an "real-time task" outside of RCU that is affected by this.
> Also I prefer testing these things on bare metal so the host not pause
> the guest for some reason.

Thanks for the correction and the detailed explanation.  I agree that
enqueue-to-invocation latency is not a meaningful metric; v7 no longer
uses the QEMU result and keeps only a brief description of the tradeoff.
I also followed your suggestion to reference the existing CPU isolation
documentation instead of duplicating it.

Thanks also to Frederic for confirming the call_rcu() perspective.

Thanks,
Zixin
