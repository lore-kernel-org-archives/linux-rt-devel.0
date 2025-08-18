Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9C22A817
	for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755536168; cv=none; b=KceBQPLPxoKyoo0vY7L/H7XzGFIMLbMlCKW8zJmyx7NEjqGA/KYGsYNfHie5LM8+fwo/4yHBd04y31neO9dlGoZ5unX4JRaT+AqmDyNURq2+0IqiI4B4CNFemS1IUzVh4huQs+7aI9nD0d264feZfhKu/8PgKjX0LyALQsn3vUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755536168; c=relaxed/simple;
	bh=IFg0D4g6Egie7/QmgFZH3hnlqMPxOHmfSJD63T/Ug0M=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Iwirj+ELWegM0BlR8RguQsQT6fes/IH5nfVyWjQR5vPTs1li3iSVcZmwMTiNpUkKnBpBZo3xVGqmvMJN6c9cIS3XcMTL/lfEQQ6cC/H/EtVLUKwWsuqrA27UWbtTmHpDjRkGBgjM7lH3YopOqA1jJQzo97cTH5uplr9YRdue7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24458276e4cso4452755ad.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 Aug 2025 09:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755536166; x=1756140966;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcw7UQVd8NcuUoJtmjMZ4xGFWAzLft8voRj5P/6UCyA=;
        b=tq3dchTht4dvcvA9umIhZ8sShVDLsSwJe/bJLLpeV2DIPjx02q/Sfq1CkbmEOMmffL
         7OmA1vo7yv5dPR/OFru/UD2WXx+UO/PepwmEnU0vpf+Y8F6Au2iTqrNfS8eWOYTgVfN3
         251D4coteVW25b+9bDGhW7WedlU5J10BruATRNOPLKAjhOYfkJDlo5opWCWONmBytWNI
         br2S0MT5d65FObFnbUTtprLea90nrUN1tOVwHEHFOnek6N/av/GAisrTSRLY09WsnRQ/
         +SLL/ZJJeejGWg5RBHYaY8sG4BITqYwpueTnR9q0ThsTU1c1TfHTMW/ohPO5NSMW2oLu
         0CGw==
X-Forwarded-Encrypted: i=1; AJvYcCXWyiDAg02e+3thyf/Hw/fF8INM1XzKWxBy01sYYq6TzXp0Tm8jX3BaurLc373g3XECw1+xDL75PO67E9vjRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyadyugmNagAnA2do8KA6F/KuAcqORZASjssrxkTWfzYXe/e1+W
	f/pa139Mkbhcu0ZMmj3YQBweAXhxxhcEiFDaFOzyMMMf90qVMVc2wSz3
X-Gm-Gg: ASbGncvwzr8fpf2hHhMGfP6u4d0M/xu7EL/ZYZMYu5OZ1GoHFYP6Lq6ACqI3I90eUoq
	JFfqbjKikwWxB5Bx1hL1IT65uxqZQuGwc2ZB3UA0v9xl2017hKF2183mqi/wZrLl4EEz10P2r4s
	In4Rq2Gs1Q/3T69t+A2Kf0CPYnhVYFihTbK4zV/Bv+xydm3x+HfDOAGRa4nB943X3HeJCSfQcX2
	U4s1EhzQoI0MNcKrsMjQ7o+mvVkhfeqn1l7GquvbfWOZ9CxUVPUAY9YZGoDRKqXiHIVE8niyOdI
	k2AMeaKjcfY+IQltB2ZszO8GOijew3PMl0VLfXKZDVdNnGFUgFd+fkRYEPWeeJPSrz3CrS4YP7x
	A3Zo89Q+5zlJH08PyKZ5fGQmaFc6hZKZz
X-Google-Smtp-Source: AGHT+IGnVrA59DmOzJy5E4sN18kKqIy9b2FRTAzN1UkHFYriAbF897/ODgMzzWDNmt9+Bqs94Fa7gg==
X-Received: by 2002:a17:902:d4c1:b0:234:df51:d190 with SMTP id d9443c01a7336-2446d756119mr88110485ad.4.1755536165478;
        Mon, 18 Aug 2025 09:56:05 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb09ff8sm85254045ad.50.2025.08.18.09.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:56:05 -0700 (PDT)
Message-ID: <c15a819a-51de-467c-93fd-c321dd2e8ec9@kzalloc.com>
Date: Tue, 19 Aug 2025 01:56:00 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Berg <johannes.berg@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Jiri Kosina <jkosina@suse.cz>, Aaron Hill <aa1ronham@gmail.com>,
 Lukas Redlinger <rel+kernel@agilox.net>, Oleksii Shevchuk
 <alxchk@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, linux-wireless@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [RFC] mac80211: Potential sleep in atomic context in
 __ieee80211_wake_txqs
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I found a potential PREEMPT_RT issue I noticed in __ieee80211_wake_txqs()

 static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
     ...
     local_bh_disable();
     spin_lock(&fq->lock);
     ...
 }

This sequence of local_bh_disable() followed by spin_lock(). On an 
RT-enabled system, spin_lock() is converted to a sleeping lock. Calling it
immediately after local_bh_disable() creates a situation where a sleeping
function is called from an atomic context, which will lead to a sleep in
atomic context if the lock is contended.

The conventional fix for this pattern is to replace the two lines with a
single, RT-safe call to spin_lock_bh(&fq->lock).

I wanted to bring this up for discussion before preparing a patch. Is this
a valid concern, and would a patch to correct this locking be the right
approach?

Thank you for your time and consideration.


Best regards,
Yunseong Kim
