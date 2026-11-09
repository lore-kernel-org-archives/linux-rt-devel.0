Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240328;
	b=Rj4c6Zf7WARVBoLEyHZ/F7vCWOv8nSqdrn6fjiJQudKH6mb2GhbyZWEp5KGr1Q0bFV3v
	 Gysf95pOxmx4KF68BG2eXNjdljlXWnJNFxCfsbGyvriJsoBsnlkj5IOsUQ6gsGOmPMasx
	 ldDU+8aLmbFdbBsDGW2ISoN4cEBzIlhQNjRFcu6XuUWi+hDeEnbeduTTKkiYreQ7p2QIl
	 fjIkuH4YT4BJApMW+5vBO4duJQIEU26Y4b9DMQWD5RkhrXd8gqweAnST9+MzH+nZq5iDI
	 PjPo1g9Z5hLFOqviabutwhfIr4y6lGKWexUs8Osy8AwY2UOBPcNXMORC7BN/WY8TtYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240328;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=rD0TnuuwuM4pZL+zr/dUGguLhGYNasqzjimFQ2f+J1Q=;
	b=OTjDaNJ+ivjYahxxSPaKhWfMPq7flbPP/0LtqGpBwC+uWhj0LjOxikxt0sZe+VI4GLCB
	 tVtw57HNFIwxjcnPAQ6Vz4HGjU8GcDSFKUGn/zFvaFTYVRbJoaZzKsqRCVfXXdOJUFmXO
	 aNkZK0gmG7UEr3fncfZWiA/PLT0HhNILzQ+SOMtr30MhBN1mN4CudbVzTjDXmmq+jXBU7
	 eTH5BKjP2MGs898Pjslwh88gCAAJnA+2C7Ni+gm329YVjWXq+aVY2CBOJQXKfDOg3TcTs
	 cpIqmab7/VpCMdEgmel6aqwduSEOaJLT0QEqN8UI46r1FT127ZPGFiHXt0/4R+ilg9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dTNjyTE6;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C2606A321
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 16:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2C2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dTNjyTE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794240326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rD0TnuuwuM4pZL+zr/dUGguLhGYNasqzjimFQ2f+J1Q=;
	b=dTNjyTE6gbys4+kdkc+zDljpEm9IqAra6drLe7r7REOn7TCp10HjjXJKj8VfbrusYbzpvW
	NQJH3DaSqYxtV8iXFEI2TnyFroSSPkIVChF+KukEUm5Wrj96aEh2Fgbov/++7/XfQE8JK4
	ZV8v5SutxWsxP43PKa5XP4ufopeRgZ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-kk9qV8OsMEikZisLIleNkg-1; Mon, 09 Nov 2026 11:05:25 -0500
X-MC-Unique: kk9qV8OsMEikZisLIleNkg-1
X-Mimecast-MFC-AGG-ID: kk9qV8OsMEikZisLIleNkg_1794240324
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so12524595e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 08:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240323; x=1794845123;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rD0TnuuwuM4pZL+zr/dUGguLhGYNasqzjimFQ2f+J1Q=;
        b=H9I7sIUBmGD+4KLJPHOqSiWEXAV45nE4M7uVhU15Bwj/A5LasJzg8FqR2Nb0x2Ourr
         eVMN5FjUfHvuTofb7G9gn0JOxv2hq++xjKYPr7wAPwGV+rVof0o9bvdHXRXk4YkWnLSh
         l3BAVtAqeAlp4nTu28yD5x2WBAOjGVHjOrn1s01+mykM1GvQT1GvX//Y+0TpQPZzQobX
         qYF3Abb49KpTuJxnwfMgXHWNQTeqv52vJ6v3krua8nrpP5k6WWE7e/3kIZBWsINEkqI9
         93Fjo/DSveZYLqMW9xFRAjDTSYskKvFwJA1eJKaiRZaXztquNz9P5EONf7Fw1S96PW+c
         xD8A==
X-Forwarded-Encrypted: i=1; AL+hErEyStsFTvX4q72hgpmL26/2i4rewaShtzJg4uxwcq7k4YqEKlryFEspdbqMBD0dH+qLytl0W3M2DKrMPhskaQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+i/+BezAmXgyzNUr7xCUpkjJzqkC1FA8aZc9yfsfBzWH0ZyPle
	jW9xP5RwmNfuMVd3JTqfqZPYTA+Bkmth4OknX91RnzSjQphrItKjoKjK5W+bilKn1gZAd8ORTXT
	MoFDSwVB05TQtCCyDcOkbG5U8aKDudwlTqfYVIQhn3b4lJee4p6bHfyYXB71bXHjlisdj
X-Gm-Gg: AYBFou1GDHbMGIViRKyk4Lw7G7k415lToQECGgHZdSnNFoiFml1jEt+nuVPbBst3x9X
	mDlYR6dPjiwYk5/hY+rybAcE3iv4Xhw10gt2UsI0ezMp9Wx3i0NTWRYpqjAm5vW1UJf8XVCtzA7
	qkZ/abgXwY7GsE2HJ5mT4p6kAQMMqP3V2sfWZ3tZ2eXDXg5yMKJQ+T75qvb11pSfe8ZQdgM3ZxK
	+tj6AdK2sL4b7inTTgOh2E+ymcPQHyTUZvmywCM2ltPDR82gyXfkp4m2uceTRdf50ZSm714YVhV
	qgPvE4eVGMdKbRosm3ODOUsnIUsVLw5k4j/g9orfKV5xlrQiKrZVuAvMPhWjmPpo91pmsHTUbu5
	YfBprSooGKxp7A6taG4G63BurnnnmCuHm4x2ptbpAUdvEGJGxQWm5s0BqDqp/cSq5uEMPBRTHKL
	kLew==
X-Received: by 2002:a05:600c:19d3:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4b9633cf337mr86690775e9.9.1794240323539;
        Mon, 09 Nov 2026 08:05:23 -0800 (PST)
X-Received: by 2002:a05:600c:19d3:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4b9633cf337mr86690105e9.9.1794240323029;
        Mon, 09 Nov 2026 08:05:23 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596acf465sm12474800f8f.21.2026.11.09.08.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:05:21 -0800 (PST)
Date: Mon, 9 Nov 2026 17:05:18 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 07/29] sched/deadline: Do not lose a throttled task
 switched out and back
Message-ID: <avHvPjz4dL0zNyGb@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-8-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-8-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PvtGEgmkm13UTrH0TfJ3y2QfAg40OtiG0t6t-ZCIBeA_1794240324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A SCHED_DEADLINE task can be throttled, switched to another policy, and
> switched back before its 0-lag time. It may then never run again, not
> even to die of a fatal signal.
> 
> A task that leaves SCHED_DEADLINE keeps its parameters until its 0-lag
> time, so that leaving and coming back gains nothing. Commit 209a0cbda7a0
> ("sched/deadline: Improve the tracking of active utilization") moved
> their reset from the replenishment timer to the inactive timer, which
> switched_to_dl() cancels.
> 
> This misses a task that was throttled when it left. An overrun can put
> its 0-lag time after its replenishment timer. That timer fires while
> the task is out of the class, and does nothing. On the return of the
> task, enqueue_dl_entity() leaves it to that timer, which has fired. The
> task is then on no dl_rq, with no timer pending, until it leaves
> SCHED_DEADLINE again.
> 
> Fix this by replenishing the task when the timer finds it out of the
> class, as for a throttled task that is not queued. Its return then
> enqueues it.
> 
> Clearing dl_throttled alone would not do. It would forgive the overrun.
> A yield left set, or the old deadline of a constrained task, would
> throttle the task again. The Sashiko AI review of the first posting
> found this in the first version of this patch.
> 
> A cgroup selftest under development hung on this bug about once in
> 1350 runs. The throttled_round_trip case of deadline_switch_test, added
> later in this series, fails 8 times out of 8 on v7.3 and v7.4-rc1. It
> passes with this patch.
> 
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

this still fixes the hang, so my v2 comment stands: take it, and keep
working the potential additional re-entry corners separately.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Still have to review them properly, but between 09/29 and 24/29 I
believe every return at or after the 0-lag time is now covered, that was
the bulk of what I was "seeing more of" in my v2 review.

What I think is still open is the other half: a return before the 0-lag
time, with different parameters, where the budget carried over from the
old reservation is never validated against the new one. IIUC that can
only buy a task one instance past its new admission (it converges at the
next replenishment), so it should not block this series and we can
discuss separately/later on. Just mentioning here so that I hopefully
don't forget.

Thanks,
Juri

