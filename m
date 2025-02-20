Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3001FC7C1
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066057; cv=none; b=M0+9GHz7FlEea18snlY9SJx7FZ4iUs74z/UiUslaFR3ym+3KMNuHZxrys3f0qt2zuHi/rKpF+AscoU+AyCpLGa5z8383jpjgkacFgxGcjKDpcV819HE1YdYRp10Ij5KkiXssOzUraX5GiXnsr9wocdxrnG5zSoZcnoZ+a4Aznqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066057; c=relaxed/simple;
	bh=XHNz2LwepouDOIXy+bmb3D7UCDqdWRymySARZERzu0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5/3fN4nc7XfZf/JGOvB8bnQzxmaHP13Q0bDP9Rpk5qGZN24L5c0uelMQW+oquPn/ZT64O27IQkPtxrDf2EMH8Uy1qRhTwq2bRRhZKxfzSeoKHNVjZ2muBjZvQ1Y/dHV2a+S7pzIYMuMOhIvT+I8cRUTe69S+aN+lejjszv45dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5+9UdzV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5+9UdzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740066054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XHNz2LwepouDOIXy+bmb3D7UCDqdWRymySARZERzu0A=;
	b=R5+9UdzVmbSUUec56oNraTzlvBjKlPnekFXCVdnCXrnKPlVkmqQvYaw8+G1MooNq1Z9Xly
	vUsn+6tJU05THAxYSlVGI6XPqG5i+eoDDFX5zyD5ybQoS+nM6ioTyvLmbpfTrZgyXQcouR
	i2m4xAv/3smj/rHV7QeCAtqK6/XQpMU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-KkQnV8-WMt6wbx9OPYIDAQ-1; Thu, 20 Feb 2025 10:40:53 -0500
X-MC-Unique: KkQnV8-WMt6wbx9OPYIDAQ-1
X-Mimecast-MFC-AGG-ID: KkQnV8-WMt6wbx9OPYIDAQ_1740066051
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f29b4d4adso492697f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 20 Feb 2025 07:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066051; x=1740670851;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHNz2LwepouDOIXy+bmb3D7UCDqdWRymySARZERzu0A=;
        b=i7V5S/qR10Lkh7Cy/1eDTM0FbsECBRi7JUFY7uIu+3gcALfHXY/1G9xh3bmtpWFb2Q
         QE5KjJxk3ntfzYUaJY4nxwXRS7Tecw0MMhP8RlqswsXbjwYjumVq1Sb/kLBjp9Y8CR9x
         dhb5BYAwNyTa1GTJA/izAV5o558uGX4+n+5zvAsRo+T8tGNTcCyAapp8I4vz0Zm9TpKj
         jfWfA6oiPYlBrF0VC4/n/tWlqSVyg8xafPkce+O/1jhZMhJYxZlpWSjTcbq9LO2jBerM
         ZuslWQIX8ydENVyG1/ZWdIUeWsYDI8ZucDubCeWzef7zDB9SbX9e5miipfxGxS5SYcZn
         CsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx0ltzRTax9Ebdr1CYJMrQ5TIQ4YwNZFqHT0BQqHtPDxvtLsa/2WRs2u/ezdYtVxresPdB1QWStxzyeHEegg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPrUYcZjK6MBPJ6SAfbevjn2MIeVH4mIYHvaW37zMTVp+wiIW0
	9eCEgUCiALdtl86L0JRmkQwSHX3JWpQ0zf5K4FcTpbHF9gZfLFy9sPdS+go790eG+hqxIzHAfZQ
	SUWYonBTbUqdcOjYuRmANd3ulr0jqVp+xBgfiUE2hHyu9mh3cLG6olYyONcokbC+r
X-Gm-Gg: ASbGncv8OUXqyf35bWNBOT63pBxKayy6ikLvcjVCcAEs3cDtqChMkMPQ501Bl4cVvrY
	a1/LjwkD+eWSChe0dToOsXEnGOC+9ZexzjsswaAm6agHf8Ug6M1PF1M9Yme6BTrkbuCq3b9qXt4
	rfN6tcNNk8lJftQPBzOil0S16C32yDpsdipX7UrqS02GrbHX8f5q2dZgwk9lDMxBGdkSHbyczJU
	QC+mXXQ0sBJLs1E4r86o+WIuf/EmIbrFLyVvyLWraxdB30R8AsWuktpbV2U9Z+N/9ROOkwqxGv+
	xRv6JE8bMFegAEDLeHJK96qB5Vd6khTGjKLhoEr9Kl7s/mZH0wlE6DP4B5iy5z5BCA==
X-Received: by 2002:a05:6000:b07:b0:38f:2a5e:f169 with SMTP id ffacd0b85a97d-38f651405d3mr2086348f8f.37.1740066051324;
        Thu, 20 Feb 2025 07:40:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJepg3rIyVKWrj3xeOEkClHlAOZYXoumzKiusFghxTUIBGvYNcurpQRKe8xP1WWM4kXUgn8g==
X-Received: by 2002:a05:6000:b07:b0:38f:2a5e:f169 with SMTP id ffacd0b85a97d-38f651405d3mr2086316f8f.37.1740066050924;
        Thu, 20 Feb 2025 07:40:50 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fb6sm20683058f8f.44.2025.02.20.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:40:50 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak
 <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Ben Segall
 <bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>, Andy
 Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev, Tejun Heo <tj@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, Petr
 Mladek <pmladek@suse.com>, Josh Don <joshdon@google.com>, Qais Yousef
 <qyousef@layalina.io>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Vernet <dvernet@meta.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
In-Reply-To: <20250220113227.GL34567@noisy.programming.kicks-ass.net>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>
 <20250220113227.GL34567@noisy.programming.kicks-ass.net>
Date: Thu, 20 Feb 2025 16:40:48 +0100
Message-ID: <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r2m3_UdZS_BNPr8gS9vCmOdUG_JOC1-ShpmyxxLG858_1740066051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 20/02/25 12:32, Peter Zijlstra wrote:
> On Thu, Feb 20, 2025 at 04:48:58PM +0530, K Prateek Nayak wrote:
>
>> The rationale there was with growing number of tasks on cfs_rq, the
>> throttle path has to perform a lot of dequeues and the unthrottle at
>> distribution has to enqueue all the dequeued threads back.
>>
>> This is one way to keep all the tasks queued but allow pick to only
>> select among those that are preempted in kernel mode.
>>
>> Since per-task throttling needs to tag, dequeue, and re-enqueue each
>> task, I'm putting this out as an alternate approach that does not
>> increase the complexities of tg_tree walks which Ben had noted on
>> Valentin's series [1]. Instead we retain the per cfs_rq throttling
>> at the cost of some stats tracking at enqueue and dequeue
>> boundaries.
>>
>> If you have a strong feelings against any specific part, or the entirety
>> of this approach, please do let me know, and I'll do my best to see if
>> a tweaked approach or an alternate implementation can scale well with
>> growing thread counts (or at least try to defend the bits in question if
>> they hold merit still).
>>
>> Any and all feedback is appreciated :)
>
> Pfff.. I hate it all :-)
>
> So the dequeue approach puts the pain on the people actually using the
> bandwidth crud, while this 'some extra accounting' crap has *everybody*
> pay for this nonsense, right?
>
> I'm not sure how bad this extra accounting is, but I do fear death by a
> thousand cuts.

FWIW that was my main worry with the dual tree approach and why I gave up
on it in favor of the per-task dequeue faff. Having the overhead mainly
contained in throttle/unthrottle is a lot more attractive than adding
(arguably small) overhead to the enqueue/dequeue paths. There was also the
headache of figuring out what to do with the .*nr_running fields and what
is reflected to load balance, which isn't an issue with the per-task thing.

As pointed by Ben in [1], the issue with the per-task approach is the
scalability of the unthrottle. You have the rq lock held and you
potentially end up unthrottling a deep cgroup hierarchy, putting each
individual task back on its cfs_rq.

I can't find my notes on that in a hurry, but my idea with that for a next
version was to periodically release the rq lock as we go up the cgroup
hierarchy during unthrottle - the idea being that we can mess with part of
hierarchy, and as long as that part isn't connected to the rest (i.e. it's
not enqueued, like we currently do for CFS throttling), "it should be
safe".

FYI I haven't given up on this, it's just that repeatedly context switching
between IPI deferral and this didn't really work for me so I'm sticking to
one 'till it gets somewhere.

[1]: https://lore.kernel.org/lkml/xm26y15yz0q8.fsf@google.com/

