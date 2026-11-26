Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727047;
	b=iDU4ALGzFCsCWaMoO9mRewgfM7EA5x6bggBqlbZqkkot0dfcx336qD/BIzgVnxFfKD+b
	 S0Gry3DbNYOaVZ8F0AQZDcix8SCs+AHvpLiVU56xUrp76d+xgKEtHCwbzORVgsh38zc59
	 PcF+q4NaAWwd/CyhC1PiHs2hNP3+hL7NVfdayeGzfbGu/r+zM9bA2Dgh08p8YN0SS8lAO
	 VkcOcydYoT3oG9S+XfmsDkuiT7UQhjtg4qFdiPk6/xqyqn9A630xApJdMghwYlw3gjCzH
	 x7mMcejTTho4xg8VwCJDfkrHRwOsr/Q8h68Gur5A9V/odKar8SPxWgApKEbQLg2DEgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=NzQpi5zLFt48IXOc9gm2YIA1Vaa4QZ9J+BdHMrNcKwo=;
	b=eM2FpajhIheJJE5RR814EwY2mWxAnad0yLCNHVNYNlve14axki7C0re2j4BOdSDQEpip
	 0GAWvCp3sKo5bJSRUynvM5q1tddkQGrSTKhX6k8Dl0/3t/NmQABUZ0Xmnd+lO/ZV47BJz
	 lXhNVWuI6+JJ/14hQE/FohXyo0kxf0BistDwfJWTyIHNQxlFO/5g7kRGFMt0lmGFTLh2k
	 OMjo+Uc4t3Amd4rC2+tOQcHG/5QGUm84CwSrHnKDSjBfKwfyX35KVpBNLlY8CI6Abak3s
	 YU+QzfKXJLg2qp7GycpjQGXwhPnnV309VJIPtHr7R4tTavs5crxkqEw0aNYlDM8lONg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RkzI04L+;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94229606A321
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 21:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94229606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RkzI04L+
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb2893531bso3888473a12.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795727047; x=1796331847; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NzQpi5zLFt48IXOc9gm2YIA1Vaa4QZ9J+BdHMrNcKwo=;
        b=RkzI04L+yZ4S3Wvb+EyeJN83qUkCscGq/0XjrNXp2Am3pdnnayLP7IphUgMeEvn/vt
         31aGH6V3w9oaFL3IM8BIzpGf/oXQDDQFyGBf0SGfQagn/LkOH5K0IqpwmXllse2hzvML
         MxnRfSIKYt2/oMKN6xo94a/wqIag8+HzXTIczSLXSwlxTNpWV6GrF6obpxVj1AXKLh22
         xGKIjiU+5HD6AZkr7p2qKG9U6P2XHYuLrlL9Nh4Phmq+ntSVIUingC+msaBXXHY6Qnin
         8J8L+cLLT1m8q3/4dRPIR33W82KElqxaLEmCrfbWjKWEs9biEVvYiZt3ABnSlmbIX94D
         ywyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795727047; x=1796331847;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NzQpi5zLFt48IXOc9gm2YIA1Vaa4QZ9J+BdHMrNcKwo=;
        b=Cgfl2ACGs7m7W1n4R33s5F+BfwMig/ih37kZOldxwoeV30tuTIQsLEVOl4Otoi0LuS
         JtwKxYi9zfkBl0uQIrpdPua/OPilv0Ppo9nUw2XYOpmsoWzW3nXVnpr7j7+wyxQy++Rz
         wioRwv1MQZlbR8FiEVrwpZpBH0DQwGLDlWObBq3y1UQbnorvuGbhfvhxWFb6WbPssyJO
         /OqHAhSb+u3UkjYJFy9+nhFgmCWv0FHZG9LJjeCwhg6B/xkuo0k3PEV2NEGzzPNDLWiq
         H1JUf9fLE+EREPyxKGbGKS4+fYvGwBIre/X3bw+HbkQHKq55rHrzcxR8+yqXim0QeKSd
         xwIQ==
X-Forwarded-Encrypted: i=1; AL+hErEpLkjjddJKSqkMLpIL1MKUTZ472MT5C51MaThpROZjELfbJhNqDZO8GNfuw02dHn8HGbfUeChFio2ttvpeFg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/NPQonBEO4bHmq92KmZLOzM4Z9n5Zr94mxpNCzmFcM5n4FF4yC
	ykeOUAFzeKl3ZJ5K3A5BXNSZtzIR/mi0YwgEZCTCAk5WNPgE7suYDrnC
X-Gm-Gg: AZFdTZcM5JK9ByDmfwLiwftB3R7YaYoaQD9ybmCXCeBtOXJdBPlFjRkAHe+PS2840x7
	V/vm01fqigpMj+3JXUg4C/qaua7qEjTWyfBCeD5i2sFZhyU7nUmcYg9oPFithspTF6kIQUgY4lT
	hnof/UFJbPhKpdeo1PHPivbYNv0gasnq6bV6xdXLKga6zBTUKaIINfFKoM8ow77C3CtGr+CTEFe
	W8UB5MnINWzNbC+Z3XYNYwXyzxl0bR98JbuNc1dgveHubx5igqm2mnj/NI63FCPDpilb9QKxq6J
	af8X3VS5FiFavZBZmKxm+3VD3fWa5d33QXDxQw5FY8tY531w01Mnx6nPzyKAXsrIhAy5RX4myzK
	42qIk0L6+YGPWDN65BWlaanaGFFcUTHW7d6ZRmCuy+gX5fWOCmfiIk3l1T3TzC+IPOjI5S9fVjg
	NU3gJSpw8efjK8FBJ8enMpjEu1Cb+Kn4SuCrLW1soLl1BcIS+bbt6xgoqYthsRBAI74axGyqmb6
	PXvsmIxtFnWKyEMZy0kuPpJg9a4uK4Uv3nXAo4RzIhGWgjNDuZYggzO5fnAjPI3Xp98EzqTLXRF
	F7I3Er2vPOuPcnipAnpe0PQDvjm+6vFUY8G/Jk+edWFEpkr0+yHUq7waim4mfv0C18EH9SPrLLo
	AuDWlPiCY7rHYyUBPGgFlLoDLWNKIXqaLub0=
X-Received: by 2002:a05:6a20:430d:b0:3fb:1640:c525 with SMTP id adf61e73a8af0-4014dd5bab0mr24693403637.67.1795727046733;
        Thu, 26 Nov 2026 13:04:06 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4af1fsm11430391b3a.28.2026.11.26.13.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 13:04:06 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 21:04:05 +0000
Message-Id: <DN5G409Y1VV6.FWWRMP1I8IB1@gmail.com>
Cc: "Harry Yoo" <harry@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <daniel@iogearbox.net>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-rt-devel@lists.linux.dev>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Hao Li" <hao.li@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>
In-Reply-To: <3a44dbfb-265f-4749-b411-9491a0bcf8c0@kernel.org>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net> <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com> <20261126094403.GA49833@noisy.programming.kicks-ass.net> <aecebb39-47c9-4b0f-a076-ac0ddc7724d9@kernel.org> <DN5FM9P3X2P0.2IFD5DFBRELP1@gmail.com> <3a44dbfb-265f-4749-b411-9491a0bcf8c0@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 26, 2026 at 12:45 PM David Hildenbrand (Arm) <david@kernel.org> wrote:
>> Which part?
>
> kmalloc_nolock :)

lol. Agree. I guess it is in some ways :)

>> I don't see any new concepts of failure modes vs existing code.
>
> I hope we can sort out the rough edges.

100%
That's the goal of this diff. It removes one of this rough edges
for user's of kmalloc_nolock().
Today it can return NULL when another CPU holds zone->lock
or n->list_lock. It took long time to debug in production,
since it didn't look like lock contention at all.
With this short diff that rouge edge/corner case goes away
and spurious NULL returns disappear.
