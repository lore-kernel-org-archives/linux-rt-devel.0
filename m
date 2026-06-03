Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190583557F3
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507852; cv=none; b=aotSpf/MCxdbxiJcgUs5ozswJmMnAyF067u3boqAoYSn7Dct1SPshbEYhp3rG0A0Aw3PV3bzrMMjyDA2IZSmrxE5kWrw8YLFATBmHxTJACc52AOoO8JiIzwyymjfzASOtLbU5fP8ZrlmEF1YOJqJ+JCaMcpn6JoztmRsh+fhBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507852; c=relaxed/simple;
	bh=IevqtlrxOEFAv2AnKXkpbSRgSGyc/vrF2l+nHMSudfQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YlAh0t9FEKBZ8uKxCl6AZVabQe00f+0QxrAWhYlYr4wjtDMZ73mJDJblfnFMYt840UkZKLaxMYT85qUQycOCCbX6FlF61OKvzLxJ5PSMyrsPbaf6ur4V8lk1xf4eRyAWhjbID7142kN76i4X5hfGeRgX8YNsHQM1vTImn/9o2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=GBNN3vw/; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="GBNN3vw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1780507808; x=1781112608; i=by@by-online.de;
	bh=79d9sPSsQmWybwMoG9W424yzCHw+LqYnUnhVjS4JXCQ=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=GBNN3vw/H+iD/NTpXYv4TNBvirNf5sOCPDsxq5Q7ZVw8rdAYklipI2rflq80RUn2
	 GSWw6mEXK+lPpm911XEdY4XjcQuQxmQTrAjdJOawZOtk1kXMNJErTFgXe1KVouTWv
	 W+YMajRuCMemHfCZMxAH1WXAgHgzaqd/RZmtchkKVNTXMiAIkHi2FsO+w9GX1B/m4
	 3eJlXxBDg4Ax07pWoZfNz3Otp0yVFOzgKCMDfpgR7psJS4VgGFG20LffI/ecXh2x0
	 VfplqyUNbtu5lSHUutttNN3YMDvwyeBinhtvF5PfZhSbyeLC+6/GKPoDKFii1QatG
	 feWGnt6sq8AVZwM8oA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mk0FM-1wxXOx3Q1Q-00n8iE; Wed, 03
 Jun 2026 19:30:07 +0200
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v7 1/1] pps: pps-gpio: split IRQ handler into hardirq
 timestamper + threaded handler
From: Michael Byczkowski <by@by-online.de>
In-Reply-To: <20260602063650.LWatIBPk@linutronix.de>
Date: Wed, 3 Jun 2026 19:29:56 +0200
Cc: Calvin Owens <calvin@wbinvd.org>,
 linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 Rodolfo Giometti <giometti@enneenne.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eliav Farber <farbere@amazon.com>,
 Ingo Molnar <mingo@kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <79BC1B96-FD2C-4191-8766-6C46BF8A1089@by-online.de>
References: <cover.1780359378.git.calvin@wbinvd.org>
 <2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
 <20260602063650.LWatIBPk@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:0pc7eXEsMEdqvEiLxZ0M4BS6DgxFNGumIp0i3gkw+nad70Tw0C1
 PvrUbzh5V39DoPhEMWTRStu18WqNic2LCzW0+akk+tHewqF5d9k/szkM2qIeeAl/YXaLlke
 VbN1PsEvEZLTTI4TK1XmSPpULXyTPET/yShWeKGKwEBWkdZPtSY1kUVqWxKHEeWFX4M15MC
 /1SBviWUw+xyFe71HW3Uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qdaUOmKGcN0=;5bfWil66Tki1+MAMLTg2TRqhfmD
 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
 +w6oPgzVn1JDRxnZw0FV7ditzv33g=

Thank you Sebastian, and thank you Calvin for relaying. I appreciate the
thorough review that got this to the right shape.

Best regards,
	Michael


> On 2. Jun 2026, at 08:36, Sebastian Andrzej Siewior =
<bigeasy@linutronix.de> wrote:
>=20
> On 2026-06-01 17:44:09 [-0700], Calvin Owens wrote:
>> From: Michael Byczkowski <by@by-online.de>
>>=20
>> Split the pps-gpio interrupt handler into a primary (hardirq) handler
>> that captures the PPS timestamp at interrupt entry, and a threaded
>> handler that processes the event. This produces the same two-part
>> handler structure on both PREEMPT_RT and non-RT kernels.
>>=20
>> On non-RT kernels the threaded portion runs immediately after the
>> primary, with no behavioral change compared to the previous
>> single-handler implementation.
>>=20
>> On PREEMPT_RT, where interrupt handlers are force-threaded by =
default,
>> the previous single-handler implementation captured the timestamp
>> inside the threaded portion, after IRQ-thread scheduling delay. With
>> the split, the timestamp is captured in true hardirq context as it is
>> on non-RT kernels, eliminating a significant source of PPS jitter on
>> RT systems.
>>=20
>> Tested-by: Michael Byczkowski <by@by-online.de>
>> Tested-by: Calvin Owens <calvin@wbinvd.org>
>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>> Signed-off-by: Michael Byczkowski <by@by-online.de>
>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>> ---
>=20
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> Sebastian

