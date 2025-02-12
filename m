Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC822586C6
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382850; cv=none; b=t79U33ZYWxmT2OqWB6tq5c76++7CFFUP4YH4+Zz5VMlVmT6LUiz/z8k/Pyl4WLP5ijLGZ3kagjqKyrZqolb1VW4hLRLxcnkge+g3Rgx9NDJqv5zVQNXgL5y0zRBrdP47z8NtVjs8AHvN1OG9zYsDrwpmZaJc9z7mTODE+VFDyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382850; c=relaxed/simple;
	bh=WWpXpHggCcPdhs4VuTxxTZKC9R3iRUIwcK6EeIbV+QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnFkD6lfCt4DkGu09lXESQkC85WQ8RctUwUA1S/aRkkvkfM2V7VfH0Xmdj/b8ky3i9vxmpLI2K+HqvDoco+fKVI5XDlVuoiiLzBNU4pzvyUp0LC1M1hvPt+ZTwop6iqWMUoI9hPOM7bJmvib3PG2fk9z23361ZKK/paC3BHPuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoN4GrW/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoN4GrW/"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5451ccd7f2dso40681e87.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 09:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382847; x=1739987647; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuI5Z03zLDZiJXA9fnZE8eRXvdvS2QYxe0ggSv4hyho=;
        b=GoN4GrW/6dIGGyjIALfQDAS/A9Z4r4ItyFdmdsdllTJZzUrl6TEYEYmHzPvgwGa0Ud
         XQbug5XOWeT+j6txQ0OOGGv2O8zv+tgP71+BK5Oz6EMoj8iyTcE2HHgBbtJhekEdwxTT
         hvgpt3BNrJs1Bu9jlMsdXa8y6WhyNuPCIOFBMdnINNDWdjaBhHGaE6DQfhi4fOrxa28J
         lcCBPEt5tNZeBe6e677U01KYYlyiE8tLO9cCqByV34UkCqBQrwM03mBpG8ZrYO1IO2Iz
         A+diE94+FYnjCfskc4gPsfg3NvejnnMup5jOXzwLMp+vsBhgOoHXfGEDAvk8IJsRM7ov
         6N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382847; x=1739987647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuI5Z03zLDZiJXA9fnZE8eRXvdvS2QYxe0ggSv4hyho=;
        b=d4m+RU7TIM2ytq+6pfh5GHVrHbs/8mWpB5BPizOKFBD7C/89LO9F/oEwMPEd0wG4Zv
         vuSAG70T+1OIePuVJZz3BclmyE9oYy4BS+1eTrsQzHEzfu/+TF0XjG9ohm7P+lFTw8IG
         u4DKZCJj5pPaDDWFIpHNwpaMEFormXCcP34X/tCSNHTQOUz+IDp2tj//j6GadDa7TsuU
         v+5q2Et+8qk8XCxJ6euYU9oCQlXaCehqYn4iVS1DAfhCQrrse2+V+kpwymc8Stx9Ywfc
         W2sdLfIZ1Gedslu+LrvPzafV5WqeFYy7wDiEOH4AchBC5D/15MqvCqImLrkbJ5Cco0JN
         YESg==
X-Forwarded-Encrypted: i=1; AJvYcCUk5GfyreNPuqGhuH3uzW4hSTJAm3seJcnocarDlFCmVEzK2Jg710CyuYA5QYmYNRhoOJD5YVYYqixfuFSiWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXjui9L34hsdlivJJXNVVQSwo+EKcXOYFptBqPpxWQpbEhYjlR
	ZAeRDsLOVwi3FXBanJ39Z5nK/4LRPN9skPs+JoPsZubtOYh4Ywwp
X-Gm-Gg: ASbGncuF1QAZzeSBZ5h+oiBN903RTjeuyCpmbQ3iiyGg85BiZLnTE5r0XwCrxY6wAfK
	GKSUMgPbY2j32i6J2StqtqrIZwh+Oyp6yg8gx/cDMDA+lKQDkuCzGl3G9RRTOjUC9HUGNF/YxTb
	mkSy6E9+ir2IVcDCkY7CxbIA+YzDlbKfJ1p/u5iUaN5DutksO6pE3QYCJx4+WnNNnDo2pLKWZyL
	SYrBNed/5ATGySNu+WPPvh7qmfI/IWdnzzt7GIUNx4KBjvnVPn9iAfjlECKFzsHSsu+v1bdsgUf
	gXRS9KCJdGjNA2uFheL7Ag==
X-Google-Smtp-Source: AGHT+IGTf6/o1ewcGEUKre1zdVC8k6x+Y98jsCPQ4p9R3TflTMIiLyianinhYrX/Lsh2+4Tk7SDv5A==
X-Received: by 2002:a05:6512:124e:b0:545:8a1:536d with SMTP id 2adb3069b0e04-545180ddfadmr473410e87.2.1739382847092;
        Wed, 12 Feb 2025 09:54:07 -0800 (PST)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54410555a60sm1976613e87.87.2025.02.12.09.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 09:54:06 -0800 (PST)
Message-ID: <d0d2c78d-9ea6-43c6-8413-97d21ff77bdd@gmail.com>
Date: Wed, 12 Feb 2025 18:54:02 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <longman@redhat.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250212162151.1599059-1-longman@redhat.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250212162151.1599059-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/25 5:21 PM, Waiman Long wrote:
> The following bug report appeared with a test run in a RT debug kernel.
> 
> [ 3359.353842] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
> [ 3359.353853] preempt_count: 1, expected: 0
>   :
> [ 3359.353933] Call trace:
>   :
> [ 3359.353955]  rt_spin_lock+0x70/0x140
> [ 3359.353959]  find_vmap_area+0x84/0x168
> [ 3359.353963]  find_vm_area+0x1c/0x50
> [ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
> [ 3359.353972]  print_report+0x108/0x1f8
> [ 3359.353976]  kasan_report+0x90/0xc8
> [ 3359.353980]  __asan_load1+0x60/0x70
> 
> Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
> changes report_lock to a raw_spinlock_t to avoid a similar RT problem.
> The print_address_description() function is called with report_lock
> acquired and interrupt disabled.  However, the find_vm_area() function
> still needs to acquire a spinlock_t which becomes a sleeping lock in
> the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
> changing report_lock to a raw_spinlock_t is not enough to completely
> solve this RT kernel problem.
> 
> Fix this bug report by skipping the find_vm_area() call in this case
> and just print out the address as is.
> 
> For !RT kernel, follow the example set in commit 0cce06ba859a
> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
> inside raw_spinlock_t warning.
> 
> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/kasan/report.c | 47 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
>  [v2] Encapsulate the change into a new
>       kasan_print_vmalloc_info_ret_page() helper
> 

Not exactly what I had i mind, but this way is fine too.

Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
