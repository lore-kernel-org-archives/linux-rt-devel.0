Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465661;
	b=k6kd+ptXu7zSa9Z7wwjwE14FvC+A97tsY8+A8vwqeaEMKHbj/y4Vi6fX1mAohHRPi78H
	 1dxV/yHJl9b8ELI9HfPwVkwTTyf+N4FBhR741YtOiLPAaV37bMIWe3anUzXVOBHpQsBjo
	 WYBn/ChPZc/hjB0KDNlu176EZv91rRn3OWEyKW+IGLBuCGgGjUUYsvW+ux39FNLk4DA6b
	 Vhyvv8eBTh9G5Xs8VTzi5/PaEFQHILC7/GCA7isAoXwWGrlajwm9qazt8PjVZ3pnf+A8G
	 oAvY1JvZppn/S6zQ0OqmCFYk7moJS8EJVAENVN4wauTpd6BCQtRmolnv5QERK+oRaGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465661;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=8vDJ3Ou7xzCxze/52XPwkTIU2JyVZ1LI+BGZWXtekYc=;
	b=12j358l2gxuIRSAzT0SmUXlYLiCHjoXu/CKQ9G5fOs6V4xk+p+ckEPSRuLdh+fRLfDax
	 t+t84z/3UMtcbGFRwbPDe1/AdIFaUsRqfBrOASPprv8UIYjotVWhbhV/NJvSNt6C2auDo
	 I8QpINEa7T861K/XPo3C/pBdeZFR7zVO+27OeexyzoBTLYigzYv4c/rygWe4gLG86zXKH
	 vPSZWXCV9FPvsI7cMLuGdV9mB2PrVCwvWPRrxBITM+fNMqFAmfmBS2nvk0vJ4ny8906WP
	 YJFLQaidKDuyDo4XN0N7j+LaRBugSqMidZ47qY+8iSRP/QmLWe3W+9fQzmizv+ozM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iWQUHDNs;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64180606A337
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 06:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64180606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iWQUHDNs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794465660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vDJ3Ou7xzCxze/52XPwkTIU2JyVZ1LI+BGZWXtekYc=;
	b=iWQUHDNsHjhFt0wxMvcxPT2ry7uY/TE1npdBYyZDpjL6AuBM7EbQtptdCwtNFlJ7xE/5/i
	ljdxDvYgL8fkUdSQfZrg6oormDgK1Fon6rMQl1J6+RM4DPh0zcwJrddh1uCgUxo8GsPAGf
	wDkgDDG3npnhmJhjv92CfRPr5kLtZKI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-l4mSRXVkNK6PSrwH5QqwwQ-1; Thu, 12 Nov 2026 01:40:57 -0500
X-MC-Unique: l4mSRXVkNK6PSrwH5QqwwQ-1
X-Mimecast-MFC-AGG-ID: l4mSRXVkNK6PSrwH5QqwwQ_1794465656
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0461e040so2988678f8f.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 22:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794465656; x=1795070456;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8vDJ3Ou7xzCxze/52XPwkTIU2JyVZ1LI+BGZWXtekYc=;
        b=rHYKJvt9bsCM9DXpgzcSpvojfbIDeX19lCrtAPJXNqzUGMaFXAqiPUyT/tYadQXVQC
         CVw79ZiJ2qRm8do1gHUy0J0KM/4fFb5p0ipI4hLh70O+P4PBctL1n+OxrymXY3IGfsLx
         gGaslj4GhJWZawJAnlUxTxL+XS6O9NOtTfUY7iTCnl6p3ac/z31kNdPtie1Ki7DEASIi
         Rwm48PWCN1I8aZmAX+kNGPHa15/CIQCj3CpmVszPb4uqyKwMYuAYc8KMYYOKHsLk0lyi
         c6R+n6bqHy2EM8eBaimGa/VnfL5LVaLGhEsMHLrm/ISiT+qrNg5jjS9bqZWJ6Rmke/Uq
         yKfg==
X-Forwarded-Encrypted: i=1; AL+hErF6bApI6/x8uPoENHy2eRuMRJroQvabGgJzfZdQNgJSqUnTeMr5xHxA4FBq9ULcZMToddEeJcxqWBRtR0lSPg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8m34EDgdb4cgmHh68VITY73d+VSTfwPJl4dVP6ejmvm4i+tju3
	q2cXrVuL0Yzu75H5n7YkUVxtM8oy+wCNO3sI68tQahB+4HlQJlAJKxXfjfOliXI3ZV/pIUGDf+5
	/jPvu1hfhSgVtfNMwz/JlsVHBaT3yLz1ggvokGixULASrgbQgi0rtbPeKv1r6LT0opn7j
X-Gm-Gg: AYBFou1sxS9zGAyAVv1lLwMIJ4n5hNBhaYtG6ylJ27k9a3FNqO8y4UWNnROpU97rWIV
	7dkyXEx6twj0SA64jPMIuFNncHI/FQeE6wFUEMjz9qY7D/J2V4OY858czunOpUe0qkxjATQhnnK
	pyDW7XYGJ8XTVVrnW1zOkM7ngs2kDPbKHMvzN9V7l4IVxcTJabBXiFFGWxCDpBasqygPf4unUKK
	OnTAKBPDwkmAwyPlSCS+V4qLdRetAEFZr47UZUCsABZ914ZlaWQnHXyoup7OCTYWuelILx/pV+t
	gDq+le8cKryPlmZMx+rAp3fMj4RkAKJLP5zSgsddfxjdKq/CFFtoHcHGgXZQOWKGTJlrviWIYHI
	7JEC8l8eEsN+9Z4giVaYOgMKV5QZuA/WuESeD7ZdKsyJ3Um/tUzeCuBqXA1Pdg0jXgdNKRrJiMY
	a0vec=
X-Received: by 2002:a5d:6f16:0:b0:491:6b1b:7f25 with SMTP id ffacd0b85a97d-499c792ec97mr7218176f8f.45.1794465656002;
        Wed, 11 Nov 2026 22:40:56 -0800 (PST)
X-Received: by 2002:a5d:6f16:0:b0:491:6b1b:7f25 with SMTP id ffacd0b85a97d-499c792ec97mr7218131f8f.45.1794465655658;
        Wed, 11 Nov 2026 22:40:55 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2bf91sm15226028f8f.23.2026.11.11.22.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:40:54 -0800 (PST)
Date: Thu, 12 Nov 2026 07:40:52 +0100
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
Subject: Re: [PATCH v5 17/29] sched/deadline: Leave a dying task out of a
 rebuild of the accounting
Message-ID: <avVfdI8NRaLN0ZHH@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-18-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-18-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7-6mAz7g5pPxdkygDBpOhioFg2SYz_YegLM0l4BaB4Q_1794465656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A rebuild of the root domains' accounting takes the pi_lock of each
> deadline task, not its rq lock. A dying task past its 0-lag time
> releases its bandwidth at its last schedule. It holds its rq lock there,
> not its pi_lock. Then it clears dl_bw. The rebuild can find the task
> between the two steps.
> 
> In this diagram, T is a deadline task that exits on CPU 0 past its 0-lag
> time. bw is its dl_bw. CPU 1 rebuilds the accounting:
> 
>   CPU 0 (T)                                  CPU 1 (rebuild)
> 
>   do_task_dead(): TASK_DEAD, under pi_lock
>   __schedule(): T's rq lock taken
>     task_non_contending(T)
>       dl_task_release_bw(T)
>         total_bw -= bw
>         dl_bw_gen recorded
>         record cleared
>                                              dl_rebuild_rd_accounting()
>                                                dl_clear_root_domains()
>                                                  dl_bw_gen++
>                                                  total_bw reset
>                                                dl_add_task_root_domain(T)
>                                                  T's pi_lock taken
>                                                  dl_bw != 0, dl_bw_gen old
>                                                  total_bw += bw
>       __dl_clear_params(T): dl_bw = 0
> 
> dl_bw_gen does not help, since the release came before the rebuild. The
> rebuild would count a bandwidth that nothing releases again. The root
> domain would then refuse deadline tasks it has room for, until the next
> rebuild.
> 
> Fix this with the record of the bandwidth, dl_bw_cpu. The release
> clears it under dl_departed_lock, which the walk holds. So leave out a
> dead task with no record. A dead task with a record has not reached its
> last schedule. The walk counts it as a live task. That schedule then
> releases the bandwidth, or puts the task on the departed list. A dead
> task on the departed list keeps its bandwidth until its timer, and the
> rebuild counts it as before.
> 
> The Sashiko AI review of v2 of this series found this window. Its review
> of v4 found a gap in the first version of this fix. That version also
> left out a task between TASK_DEAD and its last schedule, with its 0-lag
> time ahead.
> 
> Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")

It's kind of minor, but I'm not sure the above Fixes is right. This
patch alone can't be applied to fix the referenced commit, it needs the
(at least 2?) preceeding patches.

> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Other than that,

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

