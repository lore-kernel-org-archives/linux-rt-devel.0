Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D69286D72
	for <linux-rt-devel@lists.linux.dev>; Thu, 11 Dec 2025 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765439943; cv=none; b=jbqTXblCLh5jPw36mTqSx2M+wGpcarIPtZDrLKPJRQzUdwsbyTg4LhA6gPh53WHpXSBpjpup2pKDwkEHPh+VbNsbtpFLWRNSWUOA7OCf3+ucSQlOM2/TOhujHVWvoD1wPlWOe9rlhrTgOUgYIO3vXRoXLmQX85/DZAdHCh/BHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765439943; c=relaxed/simple;
	bh=Mt9QZnE5lkC5YqrDO/Ugit0lJ0BF4FeMvc+q9SmfCYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8h9hWSXBa+NczMQR85sH7eLRyLcZauBbyNVTvGtToEtAbXci+EKD/QfmVETrddQjR/jqZvGZqfM0ejxUSg6qPy/COp6XDpHRyPqDTlmL1M/Ky9SjMzkO9BQswE9lQVwi4it5X6OL+coPP7+WmSUU13U4ZsawPs6Heeu7t1qWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29efc031eddso63065ad.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 10 Dec 2025 23:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765439941; x=1766044741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHLEI3yIxlF2SeW+LUeyty80pSlPWtqXZoQ2zbSMGP0=;
        b=QCqK5x5PLzFmzrPlM0LsmPynKnlvE5YwZp18jtRNazzPa98aIJfq0aHNfe+76CqVNq
         L/KQu2lOfrnOZYUL3wUDEeGQkyruXwWjQ/Upk7NrS1rIMKDDaiyCyyFy8nTrw6cIDzYl
         fj8cP6ubeHiLFTbGwZDRX8hThks4yTiGYcnjsfN+/ibFPp0u6kBU1UPPmFm5J8BFIFUy
         FN5T3CIJpCXHDsfr9J+yiLOlrJnBRjTJfIMAxZ4Jlt4CmdN+epxt2tsKpYut0Nig+9EL
         yYxjM6D4cQSBSj2gHWlgCy5GEI5b1iARgZ8Zv75USw3H5/67m6UL+sIqIoIiW0gKAD6r
         1nQg==
X-Forwarded-Encrypted: i=1; AJvYcCU+BoJ3RL7t66BN+QYjGlqG+x/Qc0ylbpabBWSThlfPkCKGF541AV7ourteelch5p3ccHeTorVaRXsls0Ywiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxA5r2XENjTg5giXDQyOPav87NRF6qEkFtG2+EBGSu59v28RPrn
	Ea02GEsqinEk8SNeuzNbSHRfbHINBR8gcdmvx6ZE56jjWgfhhGu/1J5J
X-Gm-Gg: AY/fxX76t3MQQBKdwPSjwYeih6MCZPLvc9a5KHVH3meiRLiDCgKYZN/Wmy1AfJ98Bb6
	Rof4RNTILc1h5wYG/pG6RU9pT6QiosNRrV3VtVqpDBHHVapCjAd7odQDruvtDZnh7Y0RS7uxHHy
	jGWOJQcKOdpEvgpvqrs2HZerI/5Dy+cKkd0VRiLqzovJasFLq69+YV2DR6H/zap5HZuSaAJ9i9X
	IxON1TslJyvwHm09DzfIL23PO6YbkfFW3KjP4fxfw7sUiy/sGAUZaUKNvWhc1lgq1QSTqZ8Pmjv
	jPJFR4oaNBxV3MJFaPDf91TO5Tspvz/xsf3RZJiaE+Rq09H+O6FPkO7nC463M7jfMS1MKk1Valk
	PUpHeXnPzhITG+4FplrWMfnEsauM5owrTFl7pa+zoBemy1Xz1ZDHvxclXcXiydKm9X+Sh5QWIU3
	dekXlsIQePENquu4+93i39BQI/GXyz5+qmF22av8AHxIwopvxzUiNqqEeOAqSjzAT1fTSv7sSr1
	38pcqyCp5vMcQIAqbTZ0Tiz69ZkdHrDG5AB25g=
X-Google-Smtp-Source: AGHT+IFlqKaRh2bfJ3VCJkDpWOTUAteyNHAB5/4458kCz15TVb9HB5AvTiivXYoIvGXl/ssc5/bjNw==
X-Received: by 2002:a17:903:40c6:b0:272:2bf1:6a1f with SMTP id d9443c01a7336-29eed2836ecmr13470455ad.4.1765439940704;
        Wed, 10 Dec 2025 23:59:00 -0800 (PST)
Received: from ?IPV6:240b:10:33c2:3400:bf22:fa0d:c020:cbe3? ([240b:10:33c2:3400:bf22:fa0d:c020:cbe3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38b3dsm16058865ad.36.2025.12.10.23.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 23:59:00 -0800 (PST)
Message-ID: <0d06ce4c-6ff2-401a-90d9-5a4dfd2abebb@kzalloc.com>
Date: Thu, 11 Dec 2025 16:58:55 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via RV
 (Runtime Verification) monitor rtapp:sleep
To: Nam Cao <namcao@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, rostedt@goodmis.org,
 Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Byungchul Park <byungchul@sk.com>,
 syzkaller@googlegroups.com, linux-rt-devel@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <87fraslu9c.fsf@yellow.woof> <87jyz5kuf2.fsf@yellow.woof>
 <20251202112644.YUux4LKd@linutronix.de>
 <53f17978-40e5-4b2e-b719-552612b0e775@kzalloc.com>
 <871pl1y3oh.fsf@yellow.woof>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
In-Reply-To: <871pl1y3oh.fsf@yellow.woof>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks you Nam, for pointing that out!

On 12/11/25 14:42, Nam Cao wrote:
> Yunseong Kim <ysk@kzalloc.com> writes:
>> I specifically believe that RV can encompass the role of
>> CONFIG_DEBUG_ATOMIC_SLEEP and even go beyond it.
>>
>> My reasoning is that even if a sleepable (PREEMPT_RT) spinlock is used
>> within an IRQ/preemption disabled section, CONFIG_DEBUG_ATOMIC_SLEEP
>> might not trigger a warning if scheduling does not actually occur (i.e.,
>> if there is no contention for that spinlock). This is because the actual
>> debugging check happens in __might_resched().
> 
> That's not how it works. See the description of CONFIG_DEBUG_ATOMIC_SLEEP:
> 
> "If you say Y here, various routines which may sleep will become very
> noisy if they are called inside atomic sections: when a spinlock is
> held, inside an rcu read side critical section, inside preempt disabled
> sections, inside an interrupt, etc..."

I am currently considering how to model this to cover cases that go 
beyond what CONFIG_DEBUG_ATOMIC_SLEEP covers.

My specific concern is about custom functions where might_sleep() might 
be missing. In such cases, if the code hits a fast path (no scheduling),
CONFIG_DEBUG_ATOMIC_SLEEP won't trigger. I'm wondering if RV can detect
these potential bugs.

> Nam


Thanks a lot for the quick reply!

Best regards,
Yunseong Kim
