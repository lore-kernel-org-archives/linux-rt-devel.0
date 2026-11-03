Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704748;
	b=T2+LF3bYZlp/QDAHPXwLqzdi76JPb4XbzN0b2y93Noi+FNfX+f8mn1G89HbUhSTq9HdO
	 /846mWXPVG3Y5tSchWMO1p6CoL49tO3gwBAB50mwZ3HuJgSD35X2o08KfrdonK1xpnu76
	 ppcr2gFazgR62Mj7hvVM/95qWVHfgO+jeTCL5afrQ40pTBq4BDfrNhMaG2S/QNcUu5FQM
	 shS+Nx6mKqBClkeS1nQfvICDJnJYp0luYRqkBTaS/KZRuMqpeXmCryvOqCSuVyoQ/VCiE
	 8W04/VwUsYTzsMFFau6fupWAPmaFc0hqivHiEILlxVQjsfM/93v2hBoXrkItyoUqtlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704748;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=GoGPgCpYCXIZ2TVcCltrAuHOCg1Xoc0aHaKBD0ahpDY=;
	b=TmNnZDKN47AlfQewFTAN5WfuC9O1dpADw9NAgMNcqLfMyK4YWCXcE9vgHQ/4oMou1kvB
	 C4jqn58qSQpPcd2i6K+9pJ6KPZvO1AahgFgovFWTNLx4qA8CNcmOlbxfMo8ZQwN0ZSHV+
	 6/CpXunJW/7grFY+CIyXG7Fhrf7EHlKhBCTagMVRDnnOXrJgdYtBFCBtaOe0ZDZxB8+vV
	 z52l9O0x1GboA/fxFp3qm9OmBoymePsj/sdYEzZ8BzsmV969mI91T5M+gO/J/i67nTgAz
	 izDVgMqh+nxj/1PHA7LgQkz9hB/GamZqxco7HhhA0I+qvQsHUkbl6qftovw7AN5/aQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JKy6GSDG;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D606606FAEC
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 11:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D606606FAEC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JKy6GSDG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793704747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoGPgCpYCXIZ2TVcCltrAuHOCg1Xoc0aHaKBD0ahpDY=;
	b=JKy6GSDGLI5mj7sLKVsdOFfTF2RaOPzdWG9LB7imdekqmVLwAsX2K6Y19CUCMp78lNPXGB
	js6Giowc/szheh6E+487IB+Sjrw32UwDkvhgujjoLKlRbMayFgOaQqgHFcjXQKJwyzJWJN
	f83oLs/QriHNpMuT2t+DCgbM1nVbjKE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-nd2NRHrFM5WWaknr247lIg-1; Tue, 03 Nov 2026 06:19:04 -0500
X-MC-Unique: nd2NRHrFM5WWaknr247lIg-1
X-Mimecast-MFC-AGG-ID: nd2NRHrFM5WWaknr247lIg_1793704743
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dff112136so2644800f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 03:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704743; x=1794309543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GoGPgCpYCXIZ2TVcCltrAuHOCg1Xoc0aHaKBD0ahpDY=;
        b=PA75Syh+xdhTeXASJQu2RJlLmP3gJELGzLc/A93nhjMf1rkeNjuesSGScHMh35Go5e
         MReUArNXBJUHvqeRCWIrAhoCtxpoagLBsWrS7BsnTymSESsagG7qtsWcIUF2F0KPc0mz
         P0lUPRx/3f5OuaJ0EprzTV6iDE+ms4qCFXegkR1NYjpRdEbOi55/hpA7puyk4+YrQ5/t
         2weoW+9s4PuEGO64061c0dIFLQzym5ayXv0HzuyItAAOzoMTIb874O1bGDW3hav2lcuz
         +TYfLUWD75zM7EJUfM3Jp2h6l51yHOG8MHBls5cMURx5OHAEBoYp33oFCxTWAeUKZwiU
         hbYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf5btnitvRrWhn3UyBdZ3q0P5wK+E6XXitpmm5kXkqosPhpSl2mGoJwB0fGzeHaJ7PdguUOKSHCT4YmZXXrA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+cFSyFUwrpjHoKEszneDSd8slOkOh9yVcDAap20SKzhPu/pTxH
	dajsbPwKTKdlUcL7VYQwKimHmZS3zmp48V0XLYHl3d1RkYNScShtFjfNZPVJtLNEZIzior5SnET
	jJPz1o720qAdfyHHPJm8dGeoGNqBWYUhlnTjJX+dhu/Ev951vPBCG2EJilTLJMN0qIl8chsOZZz
	deGLUVM0afaskHlHXCZfdlmB9VxrdfEx6EJPMW8ruDeOM=
X-Gm-Gg: AYBFou2Udkn5Hd94kzU+rU6/NaAPEk9lBrqhrjfin/m+ghzzQq79yoejQekAraig5iy
	2ElYXm2moxonkLzeKmtaqXOwLIdGv9RH52p2SNwnzuA3g6BrR6wi7sXgCE11++albW4hpT9Woee
	/ddzxTxvnoFjwxo4XeZcC0F6ZcK5w5pPlFgSOT1nXLvQlEgY7QqakVOyr8Ru6D8F4zLrppolwXf
	ykYgjeC7lEWucqAz9Wk2RA69kXGCGeOH3DKuYrTmVuVEMA1g1ZtukasSW9T
X-Received: by 2002:a05:6000:41c2:b0:48e:6f76:de9d with SMTP id ffacd0b85a97d-48e6f76f5e8mr28351843f8f.46.1793704742881;
        Tue, 03 Nov 2026 03:19:02 -0800 (PST)
X-Received: by 2002:a05:6000:41c2:b0:48e:6f76:de9d with SMTP id
 ffacd0b85a97d-48e6f76f5e8mr28351800f8f.46.1793704742539; Tue, 03 Nov 2026
 03:19:02 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <6adf2939.67317f00.38c4bc.00ae.GAE@google.com> <20261026224305.1254-1-hdanton@sina.com>
 <auCucDdZb8mig7UZ@google.com> <auDvUyfzg6nLtVox@thinkstation>
 <20261027163929.2bb28d5b@gandalf.local.home> <aujLx1FOc12E72rF@google.com>
In-Reply-To: <aujLx1FOc12E72rF@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Nov 2026 12:18:50 +0100
X-Gm-Features: AclHuK9TCKz_SldDuFHKUBahl0dpObHDrm8b0qWMqlbehXg4DMpHhR2Dfu-OUko
Message-ID: <CABgObfZ9mHj7Fsq7Z2S5vFy8R2Gkh2tHBATGJN2BpH=6Waks9w@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	Hillf Danton <hdanton@sina.com>, Boqun Feng <boqun@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Xz2cMXoUpmqkcvFySQ5SajblN_JaX-dvEXINk2rOV4_1793704743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:43=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> > If so, we need to make that a thread for RT kernels if you want to call
> > kzalloc_obj().
>
> Eww.  I can't imagine there's a sane usecase for memory overcommitting a =
real-time
> guest.

While I agree with the feeling, the dummy allocation path should be
mostly dead, because page fault should never (?) enable interrupts
before waiting:

#PF interrupt gate
  exc_page_fault()
    kvm_handle_async_pf()
      __kvm_handle_async_pf()
        irqentry_enter()
        kvm_async_pf_task_wait_schedule()
          kvm_async_pf_queue_task() <- registers waiter
          prepare_to_swait_exclusive()
          local_irq_enable()

The dummy allocation path is only reachable if it's an L1 hypervisor
that is getting an async page fault while L2 is running, because it
enables irq before the call to kvm_async_pf_task_wait_schedule(). I
think we can drop the dummy allocation for good, which would be even
better.

Whether you would still want to disable APF for RT kernels is up to you.

Paolo

