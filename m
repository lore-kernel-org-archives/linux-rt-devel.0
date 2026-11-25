Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616068;
	b=qRkRYcXMML8M4FQmP+QkjyctWI6U8cAQRM8nPfNWvxikoEozZ5JZKb+TD755rn5ANtBC
	 eZubKxhgnvD7N4kVzz1TA6SfbnGSsPtDiWlUrJQDEfBHlD4OFX16CHg1mLXzbg3f0xKM4
	 +jIeqzxLg3ycOavowM5B8Jt49z/r3i4a0HK8MBnQ8nZehXrMkl9gWSwJeput8an6sncIn
	 0nEIb01N0l8IlLVNJnqpIziLOSPD1R0dEAXX+Tq2lBrsyR3AUM+kCQEUQ4mDeUHFjulxH
	 FrjqvGEZBWc0MW0Pf/ZVzP3+1f0SSCCiaCqOlHnIc3T7iNwkPZB9tAJXWGM7xdfT2BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I2DpsDtmwlnqqaorb1yvKqGbKiNq2jJLn9vN0lJSvMQ=;
	b=qYDkHgSCeLSE/xtBVZ9mCrvMTGQp/vCYOlZGRhCyrD9R1wMLDKzvSBzKhH8tcoLM/NrZ
	 9mTtIfxk/FL/Q/gDZettIf08aipUDX2iO4QbovnTlwpq+aopJmLYqqAyy974p/cQSWt1+
	 kD4CJXvesWFD3BktjnPUpwrJ9i/qNfuotJ9HVuVmy06pRjCHi/gNAupWg9S8hv8pEHeYY
	 6TeiLS+owHFladid6tlWWX9fmNBcOgKMkYiXSiyBc7BK2crxQ4zoTLpQ/exwm3CciH+yZ
	 bviKUG+/LNehzEbNbn4/e6of26io2ZHF5lwYI/IMnfjnTsLa9tLyAhWdfPY9wP5eZCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=er+b1ShJ;
	arc=none smtp.remote-ip=74.125.227.201
Received: from mail-pi2-f9.google.com (mail-pi2-f9.google.com [74.125.227.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A8C606A326
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 14:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A8C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=er+b1ShJ
Received: by mail-pi2-f9.google.com with SMTP id 41be03b00d2f7-cdb8dad8ea5so855212a12.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 06:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795616067; x=1796220867; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2DpsDtmwlnqqaorb1yvKqGbKiNq2jJLn9vN0lJSvMQ=;
        b=er+b1ShJzMK5zAWVR/Xew2DWuMp86n9/ywNWVfityry248fzCSU7pG0Uqd64Qjz0NN
         JGHN69xRvtNFtQ+UAC3pZYxsJVvJtW1ZMBZnkIFfK7lBFOPL9DRzqujjru07hcSJxMAX
         8Caoo4JNOzuRYxw5d+xRmbs7jlI9Q5hh6X0G9bCBgegS8VDbtxwbu8Zr5PWcaga2SIhq
         vE5ursWiFoQrQDey2gflxGYvskRZu0ES8H1APkg2eBsGl10ZcTqay64w1Q9Yrbgok7Y9
         iCCAF1RR5AcYc3TU3e2i3kFEdiE4jrDaE0eIRQbBnp5wpZ/DYCqpVunUe8lqGQUVkS82
         h3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616067; x=1796220867;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2DpsDtmwlnqqaorb1yvKqGbKiNq2jJLn9vN0lJSvMQ=;
        b=FPugYN9WSIIMqGczHDzsaH0w61w+VM4d5/f3HVwkzIfxwXvqO9vk2rstYqJYQELPfs
         OvEWg3FrDSjYAl9LuhFAAD61ua9TB50RZU/6+vH8Fu/pLyGC8Rzqxn6hYsuXFD5FlZGv
         PNThv+1A8OJuYbZe1ryNT/Q6UsQt8Nf2dHGFj1K6YzYHJgnZPzlx0fIX+9OiIMjhV5aF
         cQ5Le1TM+62qM88kXWqEppk5+h5wqKNQRKJCblx+yXGYApqWnnGyyR2pvzx4Ei2wgVIj
         EdCUAXxSQr1/LcOCJ2A7QF47UBOhPt9miy2QzHzf3+b3lNNqcxyRpqr2ZeDDPDYgItK5
         GnZQ==
X-Forwarded-Encrypted: i=1; AL+hErEAx0bSGet4OVTs/77eEm4UKR9jIEgRHhsTv9SGUHxKmwDATj3YGw1CDklh5nuolufb7LoYfrLPgA4/tgc7JQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/M7Np+eMIwexWOxFYwFJWuiQT8Hn2/fHkKMu4eH9kMkOpXkLKc
	s1Usf8+ix635O/rfbsCoHTxKroG6JXU3Xjr6TYCC5bGBiluVBBaKgjH0
X-Gm-Gg: AZFdTZcxzJAYRjcvV7CjinZeGgEogeWG09DYHWpnVeTkgKhU4nBnRbQWfOiW48xYHve
	OK37Ykf9pKfG1YaNOEfHozeWe92mznSnW6cAjPe7Pom07ix6IGCNZTrnSrxFoEnrKS8ZT4MG8CZ
	Jkv3vA9unAg96vWaVKSN7bwmV+7XkOlD4aXfDVDS8TzHRC34boojH3UB3VZWLtdAC+lvg4droNU
	4A8bmZA3WVaFk8PERBzyE4qYiIHNso+KZ7FL+tiB5iRvR95yoGKUERfwkyB8PEYPmT+PZYI/Abq
	f74A1MxoZkaBoFTPp6MRfKZh9lndqY1VuVm0xb0zLGGfl1zws7O6jLqzqrEvihSeZ6ziBAGbZl5
	d4okveVWMqQvWAJ+ICt5wykB8Svt3oaINXxkNpcX7YGtFXq6SzZRBXmchPD/XknrsLJA6ZODI7T
	TYmy4XxGPwxpQd8Hvdms3vgaXwQWgblp8y3wOvTHiQuo5bkiMabMv6izON7ndNEBS+Rj0nVuMri
	svg9xtCFNa/l1xUh1AdHuatk79bc7mtJy4Jvq83iWFdNpnKHD2T+vZ12HIP94d99YeiMo/S44nm
	IgqeQse0reVqVdj8RqIpC+MSJxY=
X-Received: by 2002:aa7:9311:0:b0:8a0:3ed7:93a7 with SMTP id d2e1a72fcca58-8c87c38b689mr16164612b3a.32.1795616067259;
        Wed, 25 Nov 2026 06:14:27 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:3645:b698:a929:4bcd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87392d408sm8903369b3a.44.2026.11.25.06.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:14:26 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: frederic@kernel.org
Cc: Zixin Wang <w1355457260@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	wagi@monom.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Documentation: real-time: Add runtime tuning guide
Date: Wed, 25 Nov 2026 14:14:09 +0000
Message-ID: <20261125141409.330411-1-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <awbgq0xQyJATel0_@localhost.localdomain>
References: <20261125074658.33117-1-w1355457260@gmail.com> <awbgq0xQyJATel0_@localhost.localdomain>
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

Hi Frederic,

Thanks for the review.  You are correct: the CPU isolation section
duplicated Documentation/admin-guide/cpu-isolation.rst.  I checked the
remaining runtime tuning content for similar overlap with other
documentation and will keep the canonical material referenced instead of
duplicated.

On the second point, I ran a local QEMU test with the PREEMPT_RT kernel
(7.3.5, HZ=1000).  The guest had 8 vCPUs; the test process was pinned to
CPU 6 with:

  isolcpus=domain,nohz,6-7 nohz_full=6-7 rcu_nocbs=6-7 irqaffinity=0-5

The only difference between the two runs was the presence of
rcu_nocb_poll.  The workload repeatedly created and closed perf events and
epoll instances, which enqueued RCU callbacks on CPU 6; I traced
rcu_callback, rcu_invoke_callback, and rcu_nocb_wake, and measured
enqueue-to-invocation latency (including the grace period).  I ran three
80-iteration guest runs per mode, giving 480 callbacks per mode.

  without rcu_nocb_poll:
    median 4.012 ms, p95 4.203 ms, max 7.040 ms
  with rcu_nocb_poll:
    median 7.003 ms, p95 9.971 ms, max 12.542 ms

The polling mode showed Poll/WakeNotPoll events and no WakeEmpty/DoWake
events.  Thus, in this test, polling did not improve real-time response;
it made callback invocation latency worse.

I have updated the guide accordingly: the CPU isolation details now point
to Documentation/admin-guide/cpu-isolation.rst instead of being
duplicated, and the rcu_nocb_poll description no longer claims a real-time
benefit.  It now states that the kthreads poll every jiffy and can delay
callback and grace-period processing.

So far only you and Sebastian have replied to this patch.  I am waiting
for more reviewer feedback before sending v7.

The kernel-parameters.txt entry still says that rcu_nocb_poll improves
real-time response; I left that file untouched in this patch, but it may
need a separate correction.

The test logs and summary are available locally; I can share them if
useful.

Thanks,
Zixin
