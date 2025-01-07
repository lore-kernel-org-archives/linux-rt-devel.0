Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433A1E1C02
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jan 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248322; cv=none; b=G3B/eLqdj7ymXtO0JZb9c4SWLG/8y+D+pzs3rYj9SaV8GXxGxmyvzAw5htqXN8aeQYa+TkBnEvKgMA4MSZPznLnN7BnY72E4F5SoYZoQh/n9HEuopKBASAooS7NhJgjf1QBNd/Nu8arN8pJIHULGz5kPaogFjOJK5FVT6Z56l9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248322; c=relaxed/simple;
	bh=lEzP1kRy5RG3Qb48LWPiVc6zEJxtMMdbd2+7trQLmrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A8s8qGT/1X1G36HryNgdf9BMmSadBkb7U1iDDbCG+C/PHFv7992re4aZJoo7RXCIHxSWx8NJ/EtsgEqT0xGZDsof5TjAHP8JtZT9lGAaqAiKxHH9MOj9PImlhC6/E0P2IAWFtAxmkadfVF6x/e4TJaGCW5G2r7nHUPDOIgzgn3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbPx7xI4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbPx7xI4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163dc5155fso220922485ad.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jan 2025 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736248319; x=1736853119; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RgKAccMwlEvXqQoO5YfVZ/b++XMarpdfduJzqdvQEM=;
        b=kbPx7xI4uvlG/T+MSkg5D7ybR8o1+QqQCr9UYU+Tc5bdd4eWb3N5zNzb82kkr4RFye
         MR1tX+29vZO3BWYOVKIwnr5f4GF5bWVKF2/+04RpEcnVCZSyb6a70uByvP5uEYpgm1dd
         YDXzJVbPUM1O9tO8DRAptfw/VxRYAQnk9F6hZXIj8XvX+Wkk8CHBOw6UA4x95sr0d5rG
         nG5qQ2kFwrH3KN6gLBEjQg8CLn3s+s4viUSZhDXt9y5bRc7F40SlS1tWmcX53Z/fuG/I
         3anHjM6Le5Nt97cOqRPQm+ZgN729lqH7YTwh7w+mE0OSvMuCDDH1uqARbIa49uJAWLjN
         3neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248319; x=1736853119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RgKAccMwlEvXqQoO5YfVZ/b++XMarpdfduJzqdvQEM=;
        b=mBmvQ4SfXo1N5SKWaHn/Hq0SLXjoTySZS5K0QY8+yhpHNxS3LsTnjntEP5vPiuSsuv
         1bcLuh9g3CuXtYmSrA9MJ+yc2TokjP9OWVwzT/eP80s50A90AkO6UsUkf0T7GEFpvrQr
         5OUr0p+YbDZlIyvZPecInpC7DLuSdpcYll/vPhIEp0xLwxpsSWpoB3Ohn7gcp83nU1BK
         qV4v+imihXKcTbl27yZmKSxEMZ06jikO172VhlnhRkpU8WGG8tcKD/mhs6l+BMQv553n
         uSZvp82za+mTpL5EHhQaMTJPsDbfEBn99vk/xcOtkOZd0SZYVduZ47ZZA6ptVYFBDt5Y
         dcJg==
X-Forwarded-Encrypted: i=1; AJvYcCVsFivexeqqq7hSH7OXHUgn/ERGCuwEJ+Uz2iOztoSfU2dpaxZNuEnfQyBxxC/YfiKvDgozEQmWYyQ9SEgooA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2m4nWix013Npl6aZUNfKRqJJCJJ+pK980LrPQMxtmJpVIpleI
	KLWsxYRCWKMzKHxaOgmlNZxn+cMdEXrP8EvU1exRx+fM/jvv9FdOKKmREw==
X-Gm-Gg: ASbGncsEqdteKiMiXKhW/LL/CznELORmt5qoQNbKS0doEk9Fds8/bZHh70vuzfLKLsN
	CA0p5AGYXHU6vBvGvIb+JmYIolH8CS0RLMpDaOMkfjqtf9GTErgqA1d9XmL6jlNWQXGmkoGkpr+
	vlRZYJzRaFmQ4vLBK+moty3eT8st1tnbwXEmVyEoq0B1FfWHsbTiovLipGnRzBw7zulNh9WQQ6z
	s5KXarz784evP1Qn1FcpZhhaSBc2Hzwpu6pT5dBRcfwDYFZ53wLcdIZMzpsiQAx40H8ANx0uwSB
	d2of/llNYuwP8cNoIo2MeZEKgUw=
X-Google-Smtp-Source: AGHT+IGHwHSsSQwRi2Sy0n1gRusyodf4HSulRZEkw2lNyxeUst4kmnSIkjZXW3QCT9NYqQ8pn1NB7A==
X-Received: by 2002:a17:902:c409:b0:216:2bd7:1c27 with SMTP id d9443c01a7336-219e6ebd10dmr764566865ad.33.1736248318829;
        Tue, 07 Jan 2025 03:11:58 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629acsm308242575ad.46.2025.01.07.03.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:11:58 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: llong@redhat.com
Cc: bigeasy@linutronix.de,
	boqun.feng@gmail.com,
	clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH v2] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Tue,  7 Jan 2025 20:11:50 +0900
Message-Id: <20250107111150.27315-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f3ca9b15-6365-4639-b93c-33f540448b66@redhat.com>
References: <f3ca9b15-6365-4639-b93c-33f540448b66@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Long, and happy new year to everyone!

On Mon, 6 Jan 2025 14:13:57 -0500, Waiman Long wrote:
>On 12/26/24 11:08 PM, Ryo Takakura wrote:
>>   include/linux/bottom_half.h |  8 ++++++++
>>   kernel/softirq.c            | 12 ++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
>> index fc53e0ad5..f77dc746c 100644
>> --- a/include/linux/bottom_half.h
>> +++ b/include/linux/bottom_half.h
>> @@ -4,6 +4,7 @@
>>   
>>   #include <linux/instruction_pointer.h>
>>   #include <linux/preempt.h>
>> +#include <linux/lockdep.h>
>>   
>>   #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
>>   extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
>> @@ -15,8 +16,13 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
>>   }
>>   #endif
>>   
>> +#ifdef CONFIG_LOCKDEP
>> +extern struct lockdep_map bh_lock_map;
>> +#endif
>> +
>>   static inline void local_bh_disable(void)
>>   {
>> +	lock_map_acquire_read(&bh_lock_map);
>>   	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>>   }
>>   
>> @@ -25,11 +31,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
>>   
>>   static inline void local_bh_enable_ip(unsigned long ip)
>>   {
>> +	lock_map_release(&bh_lock_map);
>>   	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
>>   }
>>   
>>   static inline void local_bh_enable(void)
>>   {
>> +	lock_map_release(&bh_lock_map);
>>   	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>>   }
>>   
>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>> index 4dae6ac2e..a8211ba9a 100644
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -1073,3 +1073,15 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
>>   {
>>   	return from;
>>   }
>> +
>> +#ifdef CONFIG_LOCKDEP
>> +static struct lock_class_key bh_lock_key;
>> +struct lockdep_map bh_lock_map = {
>> +	.name = "local_bh",
>> +	.key = &bh_lock_key,
>> +	.wait_type_outer = LD_WAIT_FREE,
>> +	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
>> +	.lock_type = LD_LOCK_PERCPU,
>> +};
>> +EXPORT_SYMBOL_GPL(bh_lock_map);
>> +#endif
>
>All the locking code use CONFIG_DEBUG_LOCK_ALLOC to determine if 
>lockdep_map should be used. Should you also use CONFIG_DEBUG_LOCK_ALLOC 
>instead of CONFIG_LOCKDEP to be consistent with the others?

I see, I wasn't sure which CONFIG should be use here. Thanks for
pointing it out! 
I'll use CONFIG_DEBUG_LOCK_ALLOC for the next version.

>Cheers,
>Longman

Sincerely,
Ryo Takakura
