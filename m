Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632523;
	b=qwqMuKGrtWp+Fizi4wfE6O5mTsFHiNXOt8Uudbmt1oRw3Mfp0DLO8OFExahO0Lff0Mg+
	 RHzjFzBzIrWBwFOv72S6xiVkTDyLLPO99djsfah1eJ99/qn0UC5g9NTbYqPY8yY0XOVZl
	 ul82L0iZFDbmAVPnGD5AIX3Lkj4Uuc06q4EiGlAs2Qr8c7AuoHRI9yysnLdQjyHDnBW9F
	 XYsb9s45MPZuHeKjtCh1vY39XRTRJb+UXpuqdpx/RWtGQ6Sp/xx7gXZfC93VYZTjI0H3n
	 xyLqtZvntAQFL0q3+/an3BeWhevr5WljdUe06LLzJL0Zc4oppw1jguryv6AefG/XzlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uslC4FnJpKGu4fXxxhRPOOfMsIJImwUJFmWZBF9HWbc=;
	b=rMusiV2vCgqRgHrDHTmNJprISHrc7septM0yq7UQUUbMgCvaepk8H6BEVrL3FGn4aq3U
	 ivR88ggCkr13dNYQx6ZlQ2L8jYfqSXvPs3CojWVNLFe+bP0/qXuM1cblAz5Amh+ekv1+M
	 hmjOmxRT3insIDOQtqMijyyp43qlRDdARttomrAed3ljgkb5GHUgBhVw8i5RiNahrUcr7
	 g09sKBW8cau3DDWhJSeGZ29esdAAwYTKGWhBmDcS5QmVaVDKUM58krj7KKuAUe2fTXEw7
	 fkoAPn8fdkgO8iCeT7vDs7lU0zvGuImoLS5hKjN3BJy3TnuUJsmKBHGEs3ITCQj4EwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g/OCenPc";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4F6079078
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 15:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F4F6079078
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/OCenPc
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso1229071f8f.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Nov 2026 07:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632522; x=1794237322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uslC4FnJpKGu4fXxxhRPOOfMsIJImwUJFmWZBF9HWbc=;
        b=g/OCenPcTWq3Kv2tPNyq/K7hM3e7iANUXXpYBwYrBvTAB4HlyBxhTSzZDXYCiV2ilJ
         cWVS4ksINajgF2k6yx6vpdc3rEZ0wnRVM3QcXS32YAZmP49GAHTGIQRBZSxnPyK7OKQM
         7m2+eUgPDPOjb2s21l9OqzaDyDjssmiuySGiO71HC/K+u1TZi7Nl5g7cpnVjnKdZrSr3
         aNsmunexdiqpgdlMP4+pbttU+xeORrSL//q381p7cmc7vyUCtfwebVNTAge7Keq+nKzi
         agbwq45kBqwOdf0lW0O+9q7BWoAEQzDhxUin2ZRjMS3CnRJcYAHDj52nllndwFcBDhMq
         iJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632522; x=1794237322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uslC4FnJpKGu4fXxxhRPOOfMsIJImwUJFmWZBF9HWbc=;
        b=SL25zMHLq2nUySIzdq/eEpCplyp69n+87lHE2PWgIu8WTZvUJ8IKOjg90tUnuAh/vT
         S23p1vL1vvQq8EMGtLYxFqsidATmcmv2Ta6tEfGM0OWRDHT27ATrCFK9hqLWqS2KB/Zv
         MC/UjM22qRk6QnVVb0nYNvhzYfrDQX846nAgM2Bcx8C6oIian4zeUa6Heg47s5NfOBeN
         ttr9mcTDwpZ6Zy4heaBaSORfMvtww7+W233J4WtZmLCWpkR4lPDb5MOlQOj9WyTNgFmy
         QVPMemo4TeTe5aQNIsNNxcoUZiDe4qOnhkjc6HQzgLiDhSHfFINV605Mnq3RInrS/CPI
         LmFw==
X-Forwarded-Encrypted: i=1; AKwUvByAvFgj1sQCb1z7xJ5q6GB4Y1eJTQGW7mJaHlJ1BtytDxIU5sTDzJ8hU081sasLlmCZ7IgUadTNK/KqXKHVkw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK8qdR7v10EVkwv+AKLr74hzF4Ix9lKF5Qv9Lo10f0P8ekEoS0b
	//Rmxnozgi1S71doLNpzQ1mSUEKdywP5XrmOs2nnjFEyTPHpjF9E1xm8
X-Gm-Gg: AYBFou1CZZY3F4FxJiHK7RFuGb8/ZgrpGVgJKhnYLhsCCT7FWnfZlPXKqS1ltf6Imcc
	f8if1S9YxZ41DZgcyn3AbdVws+oFH+Gzw0W/DxSiGvJzpa1ABwXT4j/dED08Nz5c/qraNwf8q2U
	O0bGhaH8z37tmdQjRtcr2/HQtCvWuUoXCcL8QAy5B1T2iyrct23+dG7Wcb5AqMFu9CsOLhZBF00
	ObKBZACMC7JU3EEJonLvgKDJcIXFZnuGyNtM9KHadcUZY0lx4VdouFJMVRV9Y0AQdOM31smVJ3W
	Hi+fe4VtylRP2UdgJxgOAbYcdV5yTh+lEke5nDbjL86DQzlqGROW3Asb+V/dRtXffu6/kObJpre
	D6cI0Oni+wEqF39RccSksJQj//zPSfuxJ9oPc9fZXuTxIChyWkk6ZKAyKeRj0lacGgDZM4A+yVF
	CJalmuQsNzH225J8YZF7QlWk7ieD+1IkFGtlvBQSCHI4SHgfEy3VLK3g1TpJSRSby0KAkXu++2g
	aEqmX1GSBtqTE0Pt5/gs0zrG2i3TiIVFqf2l8c2a5w0WyopomIyYGFcmNX5ubZRzb7Gg/i5WcLQ
	hfgrF9ZMiiz+rWAc6duDYkFHkZnt4rfQ30CEFVI/42UEOxDb6+lglTcY6ksag2QNb4CnCCb3paQ
	=
X-Received: by 2002:a05:600c:4e14:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4ac187a80bfmr242034965e9.30.1793632521391;
        Mon, 02 Nov 2026 07:15:21 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723bfsm19309800f8f.15.2026.11.02.07.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:15:20 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix spurious -EPERM for migration-disabled tasks
Date: Mon,  2 Nov 2026 16:14:56 +0100
Message-ID: <20261102151457.364631-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <v5c3zc2sy66bsummtsvw6ciri65kc5tphm6xs752ifh5eujn6k@qflvq77fph5d>
References: <20261102135420.244745-1-parri.andrea@gmail.com> <v5c3zc2sy66bsummtsvw6ciri65kc5tphm6xs752ifh5eujn6k@qflvq77fph5d>
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

On Mon, Nov 02, 2026 at 09:45:30AM -0500, Aaron Tomlin wrote:

[...]

> Do you mind if I include your patch in my series [1]?

Thanks for the offer, but I'd rather keep this one standalone: it's a
stable fix, and it shouldn't have to wait for the debugfs series.  If it
goes in first, your 1/6 just needs to keep &p->cpus_mask on that line:

	if (!cpumask_subset(rd->span, &p->cpus_mask) ||
	    rd->dl_bw.bw == 0) {

If the maintainers would rather have it in your series, I'm fine with
that, as the first patch and with its authorship and its Fixes and
stable tags unchanged.

> Also, please detail the LLM used as per Documentation/process/coding-assistants.rst:
>
>     Assisted-by: LLM [TOOL1] [TOOL2]

That tag is gone as of v7.4-rc1, which this patch is based on: commit
1e035297ffda ("docs: remove Assisted-by references") dropped it from
coding-assistants.rst and checkpatch.  tip/sched/core is still on an
older base, where the docs have it.

Per Documentation/process/generated-content.rst, the tool was Claude
Code with Claude Opus 5.5.  It helped find the bug and write the patch,
its changelog and its test, and I reviewed the result.

Thanks,
  Andrea
