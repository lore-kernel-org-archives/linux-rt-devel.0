Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819283ABD82
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490313; cv=pass; b=GNi4HU6etLrBMUdEUO2yOgRsGEMprNY4nwxbG4IqGVEsU5sSjmctBGeplyqHbU0Ck7orNx+wNlqRzDoUBhLzYNa4C+qjeMLWJpSS6iyEz94xBdx17DXKRWZWy4qXdJPr+rOvmewlKsBJ0g9FUc0pO67Eb/Cx+4lCrDCxRoZRpv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490313; c=relaxed/simple;
	bh=cXf6cC5ci22LFWsk6dhT8kwhXsita7o1zHXWTz9wSpQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HTHxKMLmNfmeVmV41p9+a2RWM1OrruZ3p8ULoZ/PmZbnXp5n8hm36A+8u0jt7GQFyDQa3WrI1hI+OrLmP5q0SYCEell5KZgR+MHJpmBFvYSWw+VT3etWGBhohzsOQI/DOif/b42/6hvXG6STdnm69ajfPd/dDIKXXflnCTX7CNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hekUm72u; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hekUm72u"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so10612373a12.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Jun 2026 05:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780490311; cv=none;
        d=google.com; s=arc-20240605;
        b=hGekCEnA157sRvq70Ao1PdPEIn+rldUSPMoXybCaBeb74scXAB8kXhhJ1F4BFCyuo2
         dbb5CSjsXR6PbxrYYr0jsjMKq8oIwJ5H/QTL/JkSGuSyk47BTKW2K5JQrx7Cx4RzWL2d
         HEj0mXn1fmenXFEMYSsSbwmM1v8m2rz0wHeTZBXglC9KGIuy1S8KLsiVOJJhP9blLcE6
         CejO1hRfgQxplA0Hui+T6vNUVJiRVNz3gKAGhHtSFaniE2lHjQ7TTftIsydDiMiPGv0f
         FuqcrT4Q6YFtiKoWmMpGs7UvMfjarD1VGue6+hHkwm3+B1RUgJM99zv1iZ+O/cTnON3g
         CXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9iYMVyWLGUGPYi+2rZcG3C6jnjPZ8Z/OqlqwNIksFFc=;
        fh=cW264wsrGboNklH+q/SMhhVOPiE3kswaENCEm9AjGQI=;
        b=NzWHjrDzRTByoR+2LZ16yzQGwGi9xemt4Z9Bz2lj/giqlk0R8rykGFr3f/vDCmYO+3
         DEA/ebvEf7vlbAldoERS2miwTFVkp9MgN75psKqIDaB1tTFKZWgyRGShwhHEJg9bjDb1
         NkuzYcut/vW6klBpOe3Hq3GB0n29dRFMI5gbNSgvetyDPuZKZsAeHlvPHGzVuTdGE2l2
         rGSzqehM9AXm5fRb3P6+a61QmyqLl4BxwkmYJdMB/U5Sm5RHeNoS+lyO/p98jSg8z4aX
         DS1QAXWph53XyP0kG53pQPkTVo1xblWL0Glx81HxEWF0y5aiHcLNZjgTQFXfUj2wDwNo
         4tiw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780490311; x=1781095111; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9iYMVyWLGUGPYi+2rZcG3C6jnjPZ8Z/OqlqwNIksFFc=;
        b=hekUm72uU4Ziq3zlYZwreUDVOb7RLdfnEJlPI26F+Qk4gxigZnFq7abPwZROTCiDJh
         a9+pmoX5KTscvSNiL56wqHVJXmwaG5ziAH/Q9EGpweVIHk4r+VaIUrzfc+7ME6w5Tix/
         ts4mutMwp6PCp12x/ijhLkxx9GIBr9CquJ8RRvfbo46Hc368DolZzTgDzn/DlcYodJXE
         YrQ7ArgfMWFwbYWVYm4LoJKDLuRl1EllNBioh1HguRFc4CH3JC5h5D3MrY/vNKmJP4AL
         nEXxYFHHeczQL/wFBGbx+haXxCnoss1/RVo6Ai2GtA3C5KsnZMSoFUW/vHCErz0tCkK9
         qkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490311; x=1781095111;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iYMVyWLGUGPYi+2rZcG3C6jnjPZ8Z/OqlqwNIksFFc=;
        b=iQxK3MNDNADiKeWXiXOjqtNRWXX+LYD7CsjT38omltokqA/CZU0YEULtHofUWSKI3K
         8Bvj6CJIQRR4lDECkkkMdOK1NPtm590y7oFIRzaLik1Vqz/+CtPNd16qmsEX3Qv7etJb
         LzJL0JK0+OSSjtcUmxg/Z0BuwjSM8HPXWYrDNTg2pR5z2XIgUSzmq3XcFcTDHYagcJVL
         HZisgPtl3//eeZiv5MVZL3WGLIuVP6JyZY5s9F+BlWimSPQOiG4Jmtg2J+6GOvuAQhgi
         Z+cCYYWU99SwOhnjVDVxsK/XIrvu5n43A/qQGvW61CS5RrkwVPs92CkBjczk84V6w/Gw
         iKGA==
X-Forwarded-Encrypted: i=1; AFNElJ9xkn5y0xlBGS/0J3pcIjrEQPUK3DX/W0jC9ZbuavE1UVu4ozX++07HosRthT+R2RYZxXv7g/ZwbGhRoSDdWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpRjOuHdydTsr04V17+fZiITjArSJuouaR7P0aSYoC6l2UxGVy
	oEsr0Dr+nEsTNTk4ucXxeIVkqGmq5mttt/G7uP2o3M56XCZkRZ5tlgzoKYv1o80H0Sjd5/bDkJz
	SD8pAZ8SicaPw733Jq/jDD3ZYeBzMsB3anV0bGyEANg==
X-Gm-Gg: Acq92OF0FxBbOHy7uLexryEVYUWbHZQJtOeQJBejec1LPv+PJHinShioKjLtPrduEtF
	M+9jdqxgzjXIL1Qi3PuoR/fxm4jI06unXS0q+J/jMK+6vGO5CtEunw3X88+niAQyJjEItsSokqI
	cDZrwP+y/hN9DYHTYUyZi3XrRUCUhEwhfBqhlZHb6cnLMrViNYO9yLnbt1TtM0TjlLCRVKkY4ES
	g4aTip0Mxdyi6EgdxvVk8QwF/lyI/PuSe/BthvY4J8T4SwchMXi//S0wyEbWkCnY/KYq8fa9YFv
	Lht27xP59xcTJP12PyaKz0LOotrQyN55j1n8/MQDE446guA=
X-Received: by 2002:a05:6402:34d3:b0:68d:aee2:7516 with SMTP id
 4fb4d7f45d1cf-68e6b4e61bfmr1579860a12.0.1780490310884; Wed, 03 Jun 2026
 05:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 3 Jun 2026 14:38:17 +0200
X-Gm-Features: AVHnY4KVq5MSIHn7_TR-VRc4NMMpaUjcvicKxoZKF8KyHgiHULmkR-mUuFLnw_I
Message-ID: <CAKfTPtCy1dPngG1918uvrHhtGv9KUEsQ2cw6k0qAQJK=F+HjfQ@mail.gmail.com>
Subject: [ANNOUNCE/CFP] LPC 2026 Scheduler and Real-Time Microconference
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Phil Auld <pauld@redhat.com>, dhaval@gianis.ca, Aaron Lu <ziqianlu@bytedance.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

We're pleased to announce that the Call for Topics for the upcoming
Scheduler and Real-Time Microconference at Linux Plumbers 2026, is
open!

    https://lpc.events/event/20/contributions/2329/

This event is designed to gather kernel developers and engineers to
share knowledge on scheduler and/or real time issues in Linux and
connect with peers. Like last year, we are joining the tightly linked
Real-Time and scheduler topics in one same microconference.

We're particularly interested in talks that:

    - Spark Discussion: The goal is to discuss open problems,
preferably with patch sets already on the mailing list.

    - Are Concise: Presentations are meant to be limited to 2 or 3
slides intended to seed a discussion and debate.

Some possible topics for discussions:

    - Improve responsiveness of fair tasks
    - Improve PREEMPT_RT
    - Improve Locking and priority inversion
    - Impact of new topology, including hybrid or heterogeneous system
    - Improvements on SCHED_DEADLINE and DL server
    - Tooling for debugging low latency analysis

It is also perfectly fine if you have a new topic that is not on the
list above. People are encouraged to submit any topic related to
real-time and/or scheduling.

Ready to submit? Please fill out the submission form at this link:

    https://lpc.events/event/20/abstracts/

and select

    "Scheduler and Real-Time MC" as the track.

As mentioned in the blog post [1], proposals submitted by July 10th
will receive a voucher. We will accept proposals up to Aug 15th but
without ensuring that the speaker can get a ticket.

[1] https://lpc.events/blog/current/index.php/2026/04/06/changes-to-registration-availability-for-2026/

We can't wait to see your proposal and build a fantastic lineup together.

If you have any questions, don't hesitate to reach out.

Best regards,

The Scheduler and Real-Time Microconference Team:
Dhaval Giani <dhaval.giani@gmail.com>
Juri Lelli <juri.lelli@redhat.com>
Phil Auld <pauld@redhat.com>
Steven Rostedt <rostedt@goodmis.org>
Vincent Guittot <vincent.guittot@linaro.org>
