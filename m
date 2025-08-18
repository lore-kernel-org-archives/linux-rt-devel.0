Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695032BF2C
	for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540408; cv=none; b=jVdQ4USFhyBT16DjX2t/Wl2ZZldxFejz2AtkaqbyVbkyOB0cdKWyy6i29Kcc1xsfA4wv0q2DU5CwpNRynS6oGOQGtyZIzoByJ+6uz/V0+Vh6i1G+iF22irMHy2HKLJDi4ZlHmtMA97wWywud3WH3RX4y+Nb5JAyBwUeJGMuNBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540408; c=relaxed/simple;
	bh=lMTqoKlk7xLY3zTY3FQIhHuKUdbPnwdeP9KDNAfowxQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jg+QNlv3dwrL6TXeL2S+pb+ddjjPseKNjT144aycKTJGYg8vP0VOkzJFTmIuBFMlxvnLGUbGaOQigf0hmTJd3wI6kakI2qpV8cOmgDbV1wQLEpvjjNMOlrS8OSkOrDYSBYTZ8qGhK9iKCnAUcI4yPO2USmgSjG98jIhNA1HItII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arJ5wTkY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arJ5wTkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755540405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVK3uDEkCghC3XgwhOYge6qWtR3Uke3YIdcaNnS7G9w=;
	b=arJ5wTkY6MDwiuOwiPkluooupL0vC/xlFXti8pGLLFkdCONuyf/dWonTEw8I78fHfO167h
	73iMcuJTDlkQvBArCPeIQWbHZ5yJP4zGfXEwqfh49/H0xvrHlmd84UyOAEAr1Dr6ieEQNS
	DOP/33lyRQzGu0/UJsk0l6Hejl/wJ4g=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-Y8ywrR7oMR-ov-YB8RRbyA-1; Mon, 18 Aug 2025 14:06:42 -0400
X-MC-Unique: Y8ywrR7oMR-ov-YB8RRbyA-1
X-Mimecast-MFC-AGG-ID: Y8ywrR7oMR-ov-YB8RRbyA_1755540402
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71e7d824c4aso20247177b3.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 11:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755540401; x=1756145201;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVK3uDEkCghC3XgwhOYge6qWtR3Uke3YIdcaNnS7G9w=;
        b=XWlKbGOt4XMQxBMcJYj+bliJfqCD9w0Z084B1E2B6bxnMHiVQFdZWJnTvHWr8KG+MV
         mrg9go1RSqp9U4+SrdM9Yy/OAytfsXm2Mb5VwpfhgSLYMJrwc1ENSDpFnLqZ4dlNVafv
         y+kx9fMtj0GTuwSrD9J5BPaREJY0BgUiGl7akfPK9nJZQNEjxIWn4hfk09Orstkwydu7
         gT0FXvWdIVyt70Aunsi805QtxgRwY8LOSATsATXRdKY0dMBwSifUec44cKhdHdKMXKZQ
         FL69FDBIkoPm8R/mD+tvPglZy9YhISilWWLYvj7JwhoAYDYPMzTsNsuLU0QpcZbX1+K4
         j5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCX78rNPOZX11BHAKUAZ5URSlV62Gg+/seUhrxPpEq5aNgiS4kgM/DOxHS8BR2x8YMpq/lrhHDK9CLbWxiyZfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa3PWAEKPqslWCbRmHcJn/LkbU0zvd6it1KUR3JHWAGx5h2/76
	3fP0Vr5ny9nkR22kGhr1CTEVmSvXilQg6YL30o/ydrle4Yynr46PoEd1Tqnzdt+6xt72uZqgjcO
	Uqsdd8SSxGnW96/Xu4cjSGK1v5inADfggy8DEDSc52P4bjJUfLWeNakFMtyhpBOiXvJX5
X-Gm-Gg: ASbGnctmHvTqMmhzg5rnmN1eUOiuctvr6AczgtDt2R2acMRfeWrbcJUeXkg3tojgr8U
	SlfW76HIpShwTk+ViQYyuHxatMhyiyQ//G8qvGCByLeUhVqShGQa7fjCfG0+HAxgHgO1M957hkN
	rSP0p5uIli+E/jrCfCj2ONC79oZbRQaRrgwCGB6qPpkDF6MO1FAYRjppg2kRPzIexC+l23ENfn3
	ZmQwXtFRvycQbNn2ULY+LLeDvGgIgTsC6w+P3DGVKxBCZjh+9YdNw/mc9b76M0BuTZORTKM/vI5
	VlBMq6AmpIxq0yUdDM87qgtqNvk5N5z2+/svPmgKCZGnP1MDxAdm9Djfjbsqjqx3GSceL9W0mk5
	2wp2MqFTVAA==
X-Received: by 2002:a05:690c:6ac3:b0:71d:500b:d233 with SMTP id 00721157ae682-71e774ac6b0mr130376997b3.15.1755540401666;
        Mon, 18 Aug 2025 11:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZcm9I1hqrBEYRscTw5qICYVgLFE2dN4EwtkxH4owTrJSsthjzp+xz9xDEFbOj3GE+h1JnoQ==
X-Received: by 2002:a05:690c:6ac3:b0:71d:500b:d233 with SMTP id 00721157ae682-71e774ac6b0mr130376537b3.15.1755540401252;
        Mon, 18 Aug 2025 11:06:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6deb618dsm23430337b3.20.2025.08.18.11.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:06:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <db8defe4-14bf-4060-803f-e8b09a941d42@redhat.com>
Date: Mon, 18 Aug 2025 14:06:39 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Documentation: locking: Add local_lock_nested_bh()
 to locktypes
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>, Clark Williams <clrkwllms@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 John Ogness <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Will Deacon <will@kernel.org>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-3-bigeasy@linutronix.de>
In-Reply-To: <20250815093858.930751-3-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iMKVBiwexZ2dEmXlcwHZ07DKrPAmFZ8e-Hd0fu7O3Eg_1755540402
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 5:38 AM, Sebastian Andrzej Siewior wrote:
> local_lock_nested_bh() is used within networking where applicable.
> Document why it is used and how it behaves.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   Documentation/locking/locktypes.rst | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index 80c914f6eae7a..37b6a5670c2fa 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -204,6 +204,27 @@ per-CPU data structures on a non PREEMPT_RT kernel.
>   local_lock is not suitable to protect against preemption or interrupts on a
>   PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
>   
> +CPU local scope and bottom-half
> +-------------------------------
> +
> +Per-CPU variables that are accessed only in softirq context should not rely on
> +the assumption that this context is implicitly protected due to being
> +non-preemptible. In a PREEMPT_RT kernel, softirq context is preemptible, and
> +synchronizing every bottom-half-disabled section via implicit context results
> +in an implicit per-CPU "big kernel lock."
> +
> +A local_lock_t together with local_lock_nested_bh() and
> +local_unlock_nested_bh() for locking operations help to identify the locking
> +scope.
> +
> +When lockdep is enabled, these functions verify that data structure access
> +occurs within softirq context.
> +Unlike local_lock(), local_unlock_nested_bh() does not disable preemption and
> +does not add overhead when used without lockdep.

Should it be local_lock_nested_bh()? It doesn't make sense to compare 
local_unlock_nested_bh() against local_lock(). In a PREEMPT_RT kernel, 
local_lock() disables migration but not preemption.

Cheers,
Longman

> +
> +On a PREEMPT_RT kernel, local_lock_t behaves as a real lock and
> +local_unlock_nested_bh() serializes access to the data structure, which allows
> +removal of serialization via local_bh_disable().
>   
>   raw_spinlock_t and spinlock_t
>   =============================

