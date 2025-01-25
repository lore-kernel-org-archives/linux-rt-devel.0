Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756CD1EEA43
	for <linux-rt-devel@lists.linux.dev>; Sat, 25 Jan 2025 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771094; cv=none; b=BGI3A1VIQuR5XVe/TKsBIrST4sYOs7N2gIXkWS0V6VXgm6zORpVl6b/paYVGdp+Plj1ugDuD0EltdT6w2PLDCiW7o6kYhlS7F6rSSfv5Ti0kO/2xt8rIJCxKkwSdx4baC5Shx+U9L6DT0yvmH8rCsJxCS3S8TQhcWHh4hBFIOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771094; c=relaxed/simple;
	bh=cW5ZleZ3ZcP2MFmjDo1lqMOYTP8PZkxzfXP5zozKGu8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PowSkxdpH7lq+b+43KzlUusd1FuP09x69I2NZR2Haz6YC6afZUaXZw7uxnPh2sTHt9UOVn4eRVlkBCGnrgJHrG/zY7bBs/MbUdSnAP78QKBbWp48KMY9yijMOu2YdCOIV3eKxmkBVoqjaiKZffWoo3BRTrhI/THuLq9bgR9Ig2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etSBX0E9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etSBX0E9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737771091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6fDd2hy1gyD9MyTWY3pTGcfQVcmQI8cg8mKBZz1NrU=;
	b=etSBX0E9qE1eiihrnFfoaFgO7tYSJKhx2OdCJSKlGlQlZt2/iuhmAtzYJThvLoLFcP4g3v
	5bt464d1B7i5FBG/zcjXUvEj7DzQYYMotlkhvEI5lGEmHjJFmeMLV//MDG1Y8HnpRAXrS/
	on18SszS0/JfvOc8B0vw7STXJigSXZ4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-UUyd1sCJM1atkpr-kaOTgA-1; Fri, 24 Jan 2025 21:11:29 -0500
X-MC-Unique: UUyd1sCJM1atkpr-kaOTgA-1
X-Mimecast-MFC-AGG-ID: UUyd1sCJM1atkpr-kaOTgA
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e3fea893dc5so9606121276.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jan 2025 18:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771089; x=1738375889;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6fDd2hy1gyD9MyTWY3pTGcfQVcmQI8cg8mKBZz1NrU=;
        b=vxu/1SCZFLyBmYUDRgDUmoI1VgFzT6cQkdCenpkb1gdJaOwE3NHq1k9jsfN/rgq3db
         qxYDmgVwAWrDq+si5dUoi+Z0ZiAyjzBSxor65vP8wHcnIEeuN7M8p0wNl0orH/D+M6mN
         EJMPAib7JXGw3Ea/eot1hatRe5OOJ40ZwGoQIVC/vhToON8rThQTxB0pECoiqBMZvp5M
         rsmY7vf1jJwjtBziNf6aJfDoAVNqVTngfEMWRvB+LO6LZRUy5wWWcaz1yqo+2PUAA/kj
         uFBF/0Y8kF9FgKePmIBB8Z2bgRDrBXTNLYq3yMhfcPBJuULAZGyRMYNkQzePDGfTzQGy
         cgjg==
X-Forwarded-Encrypted: i=1; AJvYcCWU/SsuRcndperI5Ad93lRE4p4znzJ7PL3clI5YcF5Y0ercMculIMaNjcc53DbZI8AD2Og2rIyrzJ0wfK1tpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlbswBhlI4yCiDNEgxZn8pJixi0k93hERKPzbTMMRXPL3ia6Vl
	O55YWMtwbLZudEqOn9G7J3uVSP4+k0JqbkGKRwwKv240jPGIl7PCiuCwGg6ieA9kLYI2fuqKSDq
	qYxQP6R6cNzC6jH3gCQILbnhLChJHh6nRi+ggDZJUM/u3NjQRkQ4Krjys+ke70so/
X-Gm-Gg: ASbGncsy0YJhYArXm+cEmW3dZbihjuIgRMsUFBjiBQEID+54x4ZZOKxTtNz81Fjj/97
	rIeQujTz7fmgdNzr6j+cTNO7pz6pLPFEX9AlrT/778+Daz4BfWIHKRJEeBhkVomtWKjlpkiMotP
	UcvFGvtwN4EwhLD8S1b4Vu3fRWEvr5elsmK2YgRJuiZckJpd23GoH3pbYO5tlYLDRVFbvaWf+Yu
	pAmXNxtiHXmo+cmNBfSyavjjkVZTu++7nWn0/rB+oV4VQub3tM34wjTHc7j4O/Nva+65mF/vqio
	IX5jjLbO0cyR7zKFAjlRnYxzJHUbF8yWFBYHXPtDYMsePhMUVyw=
X-Received: by 2002:a05:690c:6204:b0:6ee:6a2a:a517 with SMTP id 00721157ae682-6f75855473dmr54188657b3.18.1737771089311;
        Fri, 24 Jan 2025 18:11:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlSNzA7NHejkrJHCqs8KBHv/2LfSlzLBJfGt6fGK5BU5IkTRO27YQkgJGsxYw966ZgFyBJkA==
X-Received: by 2002:a05:690c:6204:b0:6ee:6a2a:a517 with SMTP id 00721157ae682-6f75855473dmr54188557b3.18.1737771089025;
        Fri, 24 Jan 2025 18:11:29 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f7578770bcsm5909497b3.13.2025.01.24.18.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 18:11:28 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7532b16e-2a1d-42ee-af1c-dfb91a55d741@redhat.com>
Date: Fri, 24 Jan 2025 21:11:27 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Stephen Boyd <sboyd@kernel.org>, Feng Tang <feng.tang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250125015442.3740588-1-longman@redhat.com>
 <20250125015442.3740588-2-longman@redhat.com>
In-Reply-To: <20250125015442.3740588-2-longman@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MDpYySAe2TBb7eEI2OdlacPLBsgz6X_HHyQIDeX0hVM_1737771089
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/24/25 8:54 PM, Waiman Long wrote:
> The following bug report happened in a PREEMPT_RT kernel.
>
> [   30.957705] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [   30.957711] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2012, name: kwatchdog
> [   30.962673] preempt_count: 1, expected: 0
> [   30.962676] RCU nest depth: 0, expected: 0
> [   30.962680] 3 locks held by kwatchdog/2012:
> [   30.962684]  #0: ffffffff8af2da60 (clocksource_mutex){+.+.}-{3:3}, at: clocksource_watchdog_kthread+0x13/0x50
> [   30.967703]  #1: ffffffff8aa8d4d0 (cpu_hotplug_lock){++++}-{0:0}, at: clocksource_verify_percpu.part.0+0x5c/0x330
> [   30.972774]  #2: ffff9fe02f5f33e0 ((batched_entropy_u32.lock)){+.+.}-{2:2}, at: get_random_u32+0x4f/0x110
> [   30.977827] Preemption disabled at:
> [   30.977830] [<ffffffff88c1fe56>] clocksource_verify_percpu.part.0+0x66/0x330
> [   30.982837] CPU: 33 PID: 2012 Comm: kwatchdog Not tainted 5.14.0-503.23.1.el9_5.x86_64+rt-debug #1
> [   30.982843] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 04/29/2021
> [   30.982846] Call Trace:
> [   30.982850]  <TASK>
> [   30.983821]  dump_stack_lvl+0x57/0x81
> [   30.983821]  __might_resched.cold+0xf4/0x12f
> [   30.983824]  rt_spin_lock+0x4c/0x100
> [   30.988833]  get_random_u32+0x4f/0x110
> [   30.988833]  clocksource_verify_choose_cpus+0xab/0x1a0
> [   30.988833]  clocksource_verify_percpu.part.0+0x6b/0x330
> [   30.993894]  __clocksource_watchdog_kthread+0x193/0x1a0
> [   30.993898]  clocksource_watchdog_kthread+0x18/0x50
> [   30.993898]  kthread+0x114/0x140
> [   30.993898]  ret_from_fork+0x2c/0x50
> [   31.002864]  </TASK>
>
> It is due to the fact that get_random_u32() is called in
> clocksource_verify_choose_cpus() with preemption disabled.
> If crng_ready() is true by the time get_random_u32() is called, The
> batched_entropy_32 local lock will be acquired. In PREEMPT_RT kernel,
> it is a rtmutex and we can't acquire it with preemption disabled.
>
> Fix this problem by using the less random get_random_bytes() function
> which will not take any lock. In fact, it has the same random-ness as
> get_random_u32_below() when crng_ready() is false.
>
> Fixes: 7560c02bdffb ("clocksource: Check per-CPU clock synchronization when marked unstable")

Oh, I should have added

Suggested-by: Paul E. McKenney <paulmck@kernel.org>

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/time/clocksource.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 77d9566d3aa6..659c4b79119c 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -340,9 +340,13 @@ static void clocksource_verify_choose_cpus(void)
>   	 * and no replacement CPU is selected.  This gracefully handles
>   	 * situations where verify_n_cpus is greater than the number of
>   	 * CPUs that are currently online.
> +	 *
> +	 * The get_random_bytes() is used here to avoid taking lock with
> +	 * preemption disabled.
>   	 */
>   	for (i = 1; i < n; i++) {
> -		cpu = get_random_u32_below(nr_cpu_ids);
> +		get_random_bytes(&cpu, sizeof(cpu));
> +		cpu %= nr_cpu_ids;
>   		cpu = cpumask_next(cpu - 1, cpu_online_mask);
>   		if (cpu >= nr_cpu_ids)
>   			cpu = cpumask_first(cpu_online_mask);

