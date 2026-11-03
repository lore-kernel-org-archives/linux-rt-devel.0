Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712137;
	b=R/uHwLYw5PB+b/q4+Bp9nvimwNieVX0BgcsRi1np01K633m669jpu2j+r+/E38AujhTM
	 iqN1BWe339PRQR53pJYwdqGv0nO2/VAlbebw8kkY9mFP1CYvFWFoyX01SmwAKtlEW7PK3
	 9n8ynLn7QRJ1c6yaHJI/rO0LpLk4R2EofNv9OVWnvMtddijEeI+Y+/kTj2qIg3eqETAta
	 r+FaZ/4egpD+SeFk+KuWxDeO7YiM5eGk2DrulkktAg8DDsMUR8WVPv0MmNwzvuzHB5RdS
	 mnmcGo+hGiIcDte0tGnA+HYQIan5Hl7vP0kK5FZJ9PUosNwIr1RKEUCkpKCUFZK2qpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8Kzcx1A/Tq9zWXJslDd6YxO62sKoQa5PKvjaSVV6eKA=;
	b=KvFN085992mI1Vn/RHti4Do2+TycNTx3we5ziw8aif3PKF9WDfogvx8LHJamhQy1/edV
	 /Wr6HmvzHaVgJ/S/EjQ4FyKhw1BxI0ECH0viefbk7eS5k6/8fN/w6PXxWZ4cAp4E94/q8
	 6VRE/at3B/EykUXRvXA7NNZGii1vgqTOYrkBhb32JIpej6kPXCzu9XakNSpapr9o7zU/W
	 c3WFfi1BTEjvcrTzGnSSx04AJ2eJovAQYc9SoDQ7Loll2wHTrk9IobNvYhcHKgkm46E/f
	 kXgUCsZlf07OcwKRpf90Xit7L29l6QqvYY5PRAc5SuuQ8+z8jfEr93qF0JOncRHIsZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="T/LY9qVV";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150E606A328
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 13:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A150E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T/LY9qVV
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so46325005e9.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 05:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793712135; x=1794316935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Kzcx1A/Tq9zWXJslDd6YxO62sKoQa5PKvjaSVV6eKA=;
        b=T/LY9qVVTqqa6BqReEuCYnEK57zNnLa/+0NDswlTlI6CqKop6qJlTrvRpPiIVWYrrc
         COsXJdIknQ5xEWSi0lawOgm9N0/jtMc7gf7cJw+0riFqcRvnxjEDC/pqhiQFj5gqlLVi
         oz+/+fd/dm2YPm3fBaOPuSvAnMpMi+ScQvM1bHMJZKw7pUaYKQ8BPu1ZEYLMrxp+Kt+c
         f15EsJ0phSnGCYybtL3h/4YPVoKrXFU/EsS4oNM1LIwr2QLUCUCr2FEYX9dhBb2vsUWf
         iBL51jQmqFQSFYIgcvIZtXBw4KH9kRPwVZxz2GTwB2QhNMBKT+qfi8MElMKiCVoz/Rn9
         aYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712135; x=1794316935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Kzcx1A/Tq9zWXJslDd6YxO62sKoQa5PKvjaSVV6eKA=;
        b=H9t9MHKjQtSev2GA0ei34TBUg2zggfo/Xjj0pqEf81KLUNPww/wiYuPTFXwbH81LWx
         lUaDuP7n99PNo1ZoOo4cfQIt+n3DOziAggdzFsM/jwo+qUoIWUEGvlz5gAUFxNWaj1p2
         Q5VlQJhMGvyK9Wn2Ebqv+RCqwrcyD9x9nUbnzhyP+YVUnr5C79cSTXIETEwR4CviVq1f
         d7Jj7P5sFGExy8Oyx14l02DFkSBrFTGrezTulsndeMa84TqPgj2Xix9VV3BsGe76XuX3
         fL3vIZpLh9ICoshDuwIU+WfyjkdrxsNxBE86yLW4db7DXu3QCcXV9QiW8zH+aU7PTTN6
         icpg==
X-Forwarded-Encrypted: i=1; AKwUvBwXVWJ/vPzVMHvVeLNUaOIjIP0BIpQsy8aq0IZHvCB5w9UK7sJLlo2+zv+6rRANOnH2Dine8juDJDFQR+0rUg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+LF2AGv/CHrzeyLN4N0SHfZ6ydjEzNYhUWovgy+sIpwSqwYV5E
	j/OkaluK/3zgWIHgxWFKVkummrct1B7l9Zcz/QhexPkyo6tsRGAxHCCs
X-Gm-Gg: AYBFou1/TiKWpwMeRRf1UXGmKAxq9HZMBryXQc3GNQ0/seIwJvvQj0AhuukR1ysZSTJ
	cvNlmSHia56pavro75M04X+KsSQPOgpHsagamLhQqLK5W4An3NLckrbQkxMrLt6udyHsfUIWVTP
	CWjzWPZ5k4ZiF8F6I1t5rWd8M6n9FtGN3kWU7TxOlXAGdeCoyn6yWoTVnV5IWIpUdhk11tT1QbQ
	NSGW0RRJpFFuiM87hHII3BQBouLTqUFSpDvZx0vXEDjrxpN5jV8q0NFVwc6I9oDRrDCqkzu8vwG
	4MPhux6KRzmS0mzX+SXPGfBKgzglar2h7ho7G66wG/TnSSDBylH8o+v4TEGtKeFRnyDVg+B80Gz
	vOSDP2uv4xNl0B27/kW87xntgvwN/d2V4UIJjhvHzaSsoK/OWA/mkKYQ4UDqL5M8fpHk1XwEHYv
	cdzXhje/XPmNU4Rae+nxzANpsMkIG8qLYqvx8L7MYcwSESLKST+m9GJNC3c8o1mYuofZ1Zi+wc4
	7WLPK5S+KilrdxTZ93zOh4THK3o4H9xB6HZO0EUCczRpH7TMftiaVSwoN56Szkgua/l1H8ayv+H
	vx3eqGkQepuJ9AqGZliW7SYmV1aBJPrvI7C+Rj8sE5IkJYvVroyBE2wNeIRT+hWOdzfmfWgOBvv
	0AA==
X-Received: by 2002:a05:600d:6508:b0:4b0:bc65:b9b5 with SMTP id 5b1f17b1804b1-4b0bc65ba2bmr123679275e9.35.1793712134651;
        Tue, 03 Nov 2026 05:22:14 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa953d35sm56944055e9.9.2026.11.03.05.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:22:14 -0800 (PST)
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
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Hui Su <sh_def@163.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix cpuset_mutex double unlock in __sched_setscheduler()
Date: Tue,  3 Nov 2026 14:22:08 +0100
Message-ID: <20261103132210.4142-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aum6IBxgdiJ09Kiv@jlelli-thinkpadt14gen4.remote.csb>
References: <20261102134606.242743-1-parri.andrea@gmail.com> <aum6IBxgdiJ09Kiv@jlelli-thinkpadt14gen4.remote.csb>
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

On Tue, Nov 03, 2026 at 11:40:32AM +0100, Juri Lelli wrote:

[...]

> The fix looks good to me.
>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

> As I said in the other fix, I'm not sure we want to keep the reproducer
> in the changelog, or if it's better to start collecting them somewhere
> else (it might be easier to actually run them).

Same as in the other thread: fine with moving it to your tests, and if
you'd like a v2 with the program replaced by a link, just let me know.

Thanks,
  Andrea
