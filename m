Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712038;
	b=5FQ87SELq/sZb99646m1361OehiyyxW+G9/w/VV1u9ViiweyLZtP/kUCFCmQZqeaNAnn
	 cIB1MYOqfs8vb+bBt1l0nYGKKdY+OMPlJE63p++QwnGDAhBXsDyDXONSznfChBwSbivyM
	 rlwrAp/773yQrmwM08zYjBQ+T+PcWCHS043Jkjn2/vm+94iLxbZK1Gx4s6LYL3C26v+8U
	 xRHirDjC2PIhbY0ejG8E6qYQaWv1grgAYgcYVR574ZE5ktdaX/tiC7qYUtnAo1sC+jf6Z
	 1Hu0w+Ep1Hs7umvbCorhPkWhApGSXLOZU5FddoznVr9lI7Xj2SsbNypiRelBgKBQuEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6Q4KJJmzeQlRv4whC0gDRuh+r0dxlpIGt0aXJeqNtVg=;
	b=x9AD6YwzKOlHq8Dml06/cr7Jgs+OTHwKS3j9OPmjXK2ufLVJj8k5K8HM333wBg8JYuoT
	 VLPW/5n0rXCpqNTOeA3eokyS070Cen/6Jwg5HeOSGkKpEnDVIlt4s/hQ5WLGayYPvpS8y
	 uXMijTJcvJ1yw43ctmF0lwtnS/NRoQEjCb/NOyiadE7VZOUsiIVAXUHBZBf+USt1Tgftl
	 oKkI3iMRUM24I5YVtOEmuzCPojHoFxWVkJvHFvzFtaOMB7r9h3+0t9cOScZf+jaOIsIxO
	 CRj2es60QiZPOpnf9ABjo+AgVRWqoX1auc0FMmfAPnOBsMZ/2mgGc93rg8HGwsJ5H9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyO+8TIr;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235F606A32E
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 13:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2235F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyO+8TIr
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so40912875e9.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 05:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793712036; x=1794316836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Q4KJJmzeQlRv4whC0gDRuh+r0dxlpIGt0aXJeqNtVg=;
        b=YyO+8TIrYCeEC5+SQOnshShclET+9wn5rV1+xC5gTVIHmJieiS0h0AcQjLzfMCyUGo
         rLX+0Q+lg95YQBlecc0LrgJJpGa1QQDnC3qwGciKGtOOEEF76B7XZxiGBtlEzr8weDl9
         +TypRk/xQsM90k+AjD+zhAKFDFsoSf0/kLWRCyPrMsQpKzORNF3R55B+0w0Uj3Dtpd0/
         Pa62AU76FDIrjIdlxHACjbzV71mXLzFe4YQI0WsoWvMyWzgwufNlZZ0OrmWbig44PgEw
         rfb7g0FGQ0SOM3ympkgeuCA6GRqfUBaCp5Thj+8ylHTzr0zmPOnI6gSazEnt7outZKIZ
         0/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712036; x=1794316836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Q4KJJmzeQlRv4whC0gDRuh+r0dxlpIGt0aXJeqNtVg=;
        b=ueF0M+BxJh9ryPsTpj0TbZ/Rah40P78zxSuETQ5LOEkTV0IIZOLDdHAgINO3NYD4/r
         xbYHVB/qU5gEzRTtJpBElXsp4j1WZu5LExbtpPJTsPwkg4ugrJAXEXNSBVjZ7fQhAV1e
         VkvLlfIupjVZuIVwq61dzDDNG23kNnaFrRLvczTY7+HrFVWevjV1eMbauCm0qEmX8A4B
         Mz9azVWenKawvvVNLwtWNy7zmElctFMcS7p8UPdJD4I0ebqpeQdzLF7QljH877sIIF5j
         szXL2ba3FtQZCe7GsBRoG/yThPRpn6oXTr2VMU9zrMCVeYoj/5zGrn9xnR6HqNc7iJpf
         r+lA==
X-Forwarded-Encrypted: i=1; AKwUvBzCKPWO1r7myHTVlk508Pw9k3R8YZU2+lSho+njEmrcYuabqWh57rCST/F/17qCiUkF5hfxCDeExf+XrqRlKQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8nGQuUOQGm9+11Q8ByoI4EG2Y+/3jrKL+Wf/1tSlE0I6S4aF4X
	7i9hbsJETrLrsB8Xpj2t5BbiuEIz9bJGypB4FI6MrSqm2FpigK98YOzr
X-Gm-Gg: AYBFou0dub+CN2hkdFerHrHlK5WUvHDde/Mz6O5WPWYKSMLOEFV1oa+6yHBP29p/ufw
	voptKuBezf92a/2OIC66AYT3lBCrypLncEVFZ/5a+EeeXgnP9NTd4loIKqs5nLkAp2YFDbJqE44
	YwHopMQBKLHzvMg/hWvm4ozLVvFIn4ytdy9DYQgWOfIPrdWKtqBSmz5/nK8+DvELBdoUiszHjBe
	O0B/j//UBRf+u6h5CzatyeFmIcTA95NTVlEGhfynmzVqxN1J7JtUbX4Qg6k3ci4EHnZepFDSHpf
	1YnkOgTBqbINGrJ9rJmFbrd3vOmqY/c3I2KvP0gAP1UpinbNuOEe5vrhgciLYFzrvuifdE+uuj3
	mUJkS5pKO5WcCOJBXhQpCjatI0h5MdDBPPA1CwnhofoyO6mpfNJnJuaWZW+gGribkptCl0eaZJs
	2T15gDSmhZhydGmsKkFb8mHTAsDdTFdEFWXTQNXE+z0Gy3M0CE5fTzO6utT4tzfzxtPX2/zBAb8
	84RF/AziDorHZSFySmi0j4xA+7vRs9+6TkBXkvfuS4FDIhbaLpOZandFi0PhFFiy097/U2qqUwu
	LKCFupX34OqrDCuqUO3udIAFHZTzDNlpkwzsLRcf50dokva7HTCD2+fYdgOlRMUVwWrI08apQbW
	XVvynkDkiq36RdnKI6bG6Orc=
X-Received: by 2002:a05:600c:870f:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4ac185bcf74mr287463535e9.15.1793712036276;
        Tue, 03 Nov 2026 05:20:36 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a82cebc1sm84263175e9.1.2026.11.03.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:20:35 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix spurious -EPERM for migration-disabled tasks
Date: Tue,  3 Nov 2026 14:20:13 +0100
Message-ID: <20261103132022.4004-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aumIRjQS2M0wWlVq@jlelli-thinkpadt14gen4.remote.csb>
References: <20261102135420.244745-1-parri.andrea@gmail.com> <aumIRjQS2M0wWlVq@jlelli-thinkpadt14gen4.remote.csb>
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

On Tue, Nov 03, 2026 at 08:07:50AM +0100, Juri Lelli wrote:

[...]

> The fix makes sense to me.
>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

> I only wonder if we want the reproducer in the changelog. An alternative
> might be to move it to https://github.com/jlelli/sched-deadline-tests
> where I keep the rest of SCHED_DEADLINE tests. I can probably do that if
> you agree and prefer.

Fine with me, please go ahead, for this one and for the cpuset_mutex
one too, if it fits there.  If you'd like a v2 of both, with the
programs replaced by a link and the tags collected, just let me know.

Thanks,
  Andrea
