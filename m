Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668A1F9F47
	for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535578; cv=none; b=tessfe7whJdBWICNLlUasgD3qsEK9ZH8ZAGYRYO+hrsk4Kvv76qP/JCqV6CnjcFGMCEIrYZhusY3vMjcRNl0sBTbGRdDNAgjE0hP2tKKkhNRgbgpQ87eoshMj+zGeX/Wlv3o9U78f4ljOf+VHQ70xLxbTTG3aBuHiDsgWHTlFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535578; c=relaxed/simple;
	bh=iYZBCRkGWlqsq9n2KpK3cWf5WnuK8OJVtWX91GM5Y04=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=evz02gHYmrZFLDDsKmf2qOnCwbbvcu2pY2Dh4UdQz8LgC80IR/OKgbQH37eVPLJA3O/X19Ohdd/DZ4b/UtTwlKTq6P2GJnrtltDuHM7dRHnGOG7JyML9GP82x3jBmAAqPEyZozORMOJ2vd7EQb7K61NTyt6DTYqMQ2JI9BGmUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-244581cd072so3844605ad.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 09:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755535576; x=1756140376;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfZtpxaBwToRw8IM0N9Q3IKfSVCElSplTAz81FDm718=;
        b=ttu/Fzgjv3VqI5pkGreo/FFNgZHp0Yr3vPkH2sbPlaPbc74CLta/D8BB6KcNIyuADO
         wdsuzVtMLstgGq3ioVIlBtO2CubFU/bmEAECB5xEEuvOFo5oZiwDJ/MOxixngD+XqILA
         p27sx79vPsVXW+ujO0cGyh7Tfv0vWEpGwxMg9yuU3f+3LhIkj6ySYe5SZa2bLlhgQMUE
         wyaPNgJH/dyTeFstAr1Mq/oNywqZXGRl+UAl9H+eqcOFbjeLE+jNpAL1vg4hfbsaPEHx
         ZJosAMRR6lAyN17IUGyVTBMKdPJe0SR7UlACnjNAr6l+MBWnHO59WzRAIaRsBwVuLqvD
         UHJg==
X-Forwarded-Encrypted: i=1; AJvYcCX1GYqmzwuql4q+el0X517Ay+lXCXLiza6A/E3HEswIc+1d72vFYwVS65Vqi61L8Ttpoi8tSEzGDYRyxq6UUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgqUv0NOptireoqFpc1dRmlPTgKUvYQyaiim2+o5CQyq1cPyUi
	OL/RkkAcJeme9pur1AOa8dt9uaqOuCyHStGGWEw/ugXsp3AUCOejaxsM
X-Gm-Gg: ASbGnct93gcEfXu2kFmik2b94vRufhIjO74YtfB0qyYyOkbJdpS4WyVygH01NiN4jUy
	giZH2mXr+kQG+Q4H6sqj/9lZs0VZcTTTdK1Oya8DdAxFiEpBq2T2cTU/+jGI0Ckqpv8Xzl+U8O/
	plK/sWqjkel5rQNMz9XtJdrRlw1yfY5qgk6WTUi0k4qkHSv0dyaEj1BrI4Adp52bz0Gj2QLBcOv
	QjwvrnQViQ0Zq+BB9Zhu8A6JyMkK8/eUfVF6RmtOfSNPlquqS53OUk23LYlXPbuJNHwrejMpop7
	o1qMasUS+xXLFeOG5EpgLreFW9YOcTgM60qn3G7Ee3LFhjnKXXvjyP17jl1s7rK1yR4Yp7hRVGW
	2nzL7GwJUpfIxs5A5M7HCKb0OiGz+066HODLrgGQ7oSA=
X-Google-Smtp-Source: AGHT+IGXg7SFfXvXlQhuGYRZJ0KW95XWEuKEc6wgCSaBEYsZvTUjPxgWzwonL+HIDTjQKj+cMMnBnA==
X-Received: by 2002:a17:902:c952:b0:240:2bc6:8ac4 with SMTP id d9443c01a7336-2446d6f55f4mr84284315ad.1.1755535576068;
        Mon, 18 Aug 2025 09:46:16 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f835f7sm11758344a91.1.2025.08.18.09.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:46:15 -0700 (PDT)
Message-ID: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>
Date: Tue, 19 Aug 2025 01:46:10 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Florian Westphal <fw@strlen.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
 netdev@vger.kernel.org
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [RFC] net: inet: Potential sleep in atomic context in
 inet_twsk_hashdance_schedule on PREEMPT_RT
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi everyone,

I'm looking at the inet_twsk_hashdance_schedule() function in
net/ipv4/inet_timewait_sock.c and noticed a pattern that could be
problematic for PREEMPT_RT kernels.

The code in question is:

 void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
                                   struct sock *sk,
                                   struct inet_hashinfo *hashinfo,
                                   int timeo)
 {
     ...
     local_bh_disable();
     spin_lock(&bhead->lock);
     spin_lock(&bhead2->lock);
     ...
 }

The sequence local_bh_disable() followed by spin_lock(), In a PREEMPT_RT
enabled kernel, spin_lock() is replaced by a mutex that an sleep.
However, local_bh_disable() creates an atomic context by incrementing
preempt_count, where sleeping is forbidden.

If the spinlock is contended, this code would attempt to sleep inside an
atomic context, leading to a "BUG: sleeping function called from invalid
context" kernel panic.

While this pattern is correct for non-RT kernels (and is essentially what
spin_lock_bh() expands to), it causes critical issues in an RT environment.

A possible fix would be to replace this sequence with calls to
spin_lock_bh(). Given that two separate locks are acquired, the most direct
change would look like this:

 // local_bh_disable();  <- removed
 spin_lock_bh(&bhead->lock);
 // The second lock is already protected from BH by the first one
 spin_lock(&bhead2->lock);

Or, to be more explicit and safe if the logic ever changes:

 spin_lock_bh(&bhead->lock);
 spin_lock_bh(&bhead2->lock);

However, since spin_lock_bh() on the first lock already disables bottom
halves, the second lock only needs to be a plain spin_lock().

I would like to ask for your thoughts on this. Is my understanding correct,
and would a patch to change this locking pattern be welcome?

It's possible the PREEMPT_RT implications were not a primary concern at
the time.

Thanks for your time and guidance.

Best regards,
Yunseong Kim
