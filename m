Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC5513D53C
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578959; cv=none; b=eTJ/neLUNh8gV5V3F8FZxR++I38m/PB8DXeTkb89Mt2UDA2BagQYmDaNGRTOLxQD4qFbnCST2QdGWRz3LfJI2UvVhXd5rOSJxYQR0DYRs+Pu758zHCX9LbcdJgKvahb+QlVgW1OFIL/dNGe8x801N+7V/Ejy2gdrj4n2AXtLzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578959; c=relaxed/simple;
	bh=yof/T6h0exjB2DU0HB1ZnhVarsJT3ojXYDgAB24g5BQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9cNLdeFFif+Yfagqc49THaenfZyIMXpXVC/z/c7Oz0sw/q6yCaTKgx/FV2eb2HDMSCc3JhRDLou9ki52wS8Tx46XzNSjZYOiIJdddzXXhhOq6RvpJmpwU7do7bwO84AL45KS/ntQvGkMYne0aHrxgsDdx1PSDzAZ/Tkv/ldgTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=U74Vnvs5; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="U74Vnvs5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771578949; x=1772183749; i=spasswolf@web.de;
	bh=4ijIxJcytcvAsIkFq1c/4flGHtr/eJIAwsHrwS6sO0g=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U74Vnvs5CTSVvVHdUmfe/MvKrTmbR4dU5Wyj6Ox/Z+tPXE2Y8xc4QTGyVNCQyI6/
	 fufhWA2967+yen8lzh14M+QMMgC1kQ9RZKWMmL94eey1LxWYXEgJvpdks5Xxgpi3E
	 f6rdApIa22AnBdIYywn9moPLSLb2eDIgZ1iGfxUW6plSTi8LLzJZ5IPvkAJFvOvZ8
	 M4glmPqOGa6J71akX5kNecLb40aeqzixOAYM7Wur+oi8woRv03UXtcdZq+tFpt988
	 OMjPLwjxEOYL14AekF2l3kMY+AJtkfc3cPdgZVFkmRN9kWRgH5xGR99G+OtplT8Bz
	 Lw7clqy0Dh3GmdnRVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzTLI-1vXaZV2iDA-00zMZ5; Fri, 20
 Feb 2026 10:15:45 +0100
Message-ID: <1d56c93ee93334b9d320c93d255d7548f4497836.camel@web.de>
Subject: Re: ~90s shutdown delay with v6.19 and PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Calvin Owens <calvin@wbinvd.org>, Tejun Heo <tj@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, dschatzberg@meta.com, 	peterz@infradead.org,
 linux-kernel@vger.kernel.org, 	linux-rt-devel@lists.linux.dev,
 spasswolf@web.de
Date: Fri, 20 Feb 2026 10:15:43 +0100
In-Reply-To: <20260219195851.7a7bd1b2@fedora>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
		<20260219164648.3014-1-spasswolf@web.de>	<aZd4YCNTAHZNpTfh@mozart.vkv.me>
		<594b9094ab76acf9e73cad8fca9c9efd6f75a980.camel@web.de>
	 <20260219195851.7a7bd1b2@fedora>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hlXMMJYBu78gQ9pGj5DVmgPk0M8h08rw9q+gTahbCwkoB3T4LLr
 7Xm4ddYSUmLS7vDy5XzbnjxK002F4QXLzWtpSe226r5MBNekXQ9qR8CNvAzKjQy7A13TlTf
 hcF5Qy8GYaj5wQU9ijOFSEXGWNXwcUoMTn2KyJxLwHGz+oeOj8qzROf36dcaFBL0IwjdDLw
 zRrgfIm3h98DXgNEpFKOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SEns/F4Vjx0=;gnARmwMJTKs+GdBi7paTRGb/OcY
 kl4WIkX7iueFSiCeKC9XGxIRqvE//cs0HFmFSPI/QEB7gJBWq8K8qQvkNpgY9MH8eVHq+u+TK
 qkdsUfx4s7z5oidA4fgOR/bC+vXqvJd6y4tu5ys/91zLoBAAhVtFH7fak1Rw718EZT2cetvXQ
 L10jG1P0qj7V+Xo6Cm8N/Yefe5WUFrQh4nQaBVehZhskPUdbMqKtJN6eYJUSJUCDxc/yN2HcO
 91IbpDgd48U3NVXoj9mIBfMerDn9O7IyX42i1afd+E903bOBgpHwK7k6vzofWHp3myDonkMsP
 WBchWuEiP/wNRYcbb9/udgxWKfA1oBKyCuR6ozaefmhN7ZaHHPAysD5WxObWl71/xXyy7VVih
 EtKZmthB3OORa1pjyxw1/NiTBieBjkHgcDpqGmTcTLqJ9nj0AvD5om94bBIpOHr9eGNODEFog
 L51CNAHgE8ggb4sv1sFTw7Eeighat011WwtTEIfqXXo6geZToUgx5cEWxlvWtMpto4b3rEb4Z
 xssoMsdN3nbEYWO1QF3p83rT9MV3JAcCvRnLAjuHbV+hGCXZDRpV8uHCjX5l8cyMcDF78zXrJ
 q+0JnHyfVzMOAPCKab2QE19/SYHxi1YUDsWWwHG8G3QVqoXG+D0Pu4TaQP0gjqIZ3Hq2nfBks
 Y+03YKDzCNjx4Jz5HC8HKtQ8CZpnw4h1TDBwZpcEY01QtjvjYbY4iY9yfqKIXRYZJSe8z2fRJ
 sN1RLcfVCTaWQlrOf+FyZivcXXS2xfBloQsb7gT+ocoBO92hPv681eZ3LHgsqmMZHqtDXzWjK
 4+Vb6VEQdG/htHvAA1kSlQ1pekkOQa+zyVj5Szz11FDk1tVTnijAmqilU9wXBfWNxeM/B1Pcx
 BA7fPCiQmM6jh4vuNEq/VLymZFuP6/MNUoikDUDe74AhmsCrhGKITKrEXvBh4hfzka7YxxwOo
 jH4tZPXOtoQSol4yROaCBBmYIc1ptaHXCTSerDLQ99uWMP62TjYNKdfO/w2KFyoGgv6OGR2zh
 LUN77e8lrnSdjlEQ7i2vN1lNCaHwTtOivJHs8fq7gljH/kOmDtPU5Zpde3E7MBm2p5F37Yi72
 d8qw1tkch2u95p6tNV0Jgr9nS4Z+l74mp4auWlkEKbbmlL4yUbIjx+FYdod976wmB5ZD4tOaV
 m+ogQh59+TlBfTeBkaGTj44PZzco0iqjH9ga2Fg+Z78HpwuhrCUxdEmn3jMHtE5BcgYhmSTuY
 33da6df6r+XuNpS7gBzkbHRiVhzF/AvCQlV+3eWhiIHykzdCOdvCe7QUYLxmLXLprBR6NI+4n
 WaHcuDsgQ9kEi9PIkK5/YGitOqw+3g/V3M9Vo9mxme0WyIcZr2QDHSowF6gdVnA1q8ixt9Xjk
 8lRCLgMcoyca9Yz4/hH/ds9R+rBTiJcN50T8Z/MxG1YFR+zrNAiXKxXrHP6LAKK9KJAIzAHrJ
 By6pIVVo2JJiT7Egpssk44P7JOy8lz4wQHghj3J+n5mTfoFFhr7lhaFkO9IwTGT6RNxN41o2Q
 fEWNxC2ZHId0TjkmUxUIULGrb9YPSqFu5y5FU7DpcijatBE83V0XtiNX7WSj+5mEaYrVmP1tT
 QQGONwCQwV8O4OvHFLLL5u2+NQkn6Hwlfx54E6ooc+gKCMVEB7OCnSpvt6+6j5hfuITCTZKyy
 Gz9yyTnhIZftXsvPlBplPXF8g4zpkIdgf0SWTVcpQiT75/ApgPC7+pY36XC9DQ6OsBLXhcQ06
 A11F1OwGpVp2gRomuWn5kDk5ouXVqJmkVvc80l7f098iWG+iPuwDSygp91i7W9S62ieS6BOUl
 Bh5X9/mFL8JG2hBuw/vhBaS+kPDcgcGV7fE/FRuIrBUhkUhjWhaCQE3y4gOsWbJVSOZtSzBTw
 ojC4lcNsolaGojzrViZHVcfJSTRkXFWPIbaV1NSDAZNIjY67GGzdspVv+m3FNNZ/6p+T18jAi
 aQmw8H8UjO0TADU9V+jZccjkgvY6R0eVhRJd5nGGnlR7C0XhvNQd4rb7+c6jY+zH5vpMVDpxg
 P4N4QFRmmu/oLcR8W2AkDteBIzhz5PMvUq8w9xmeDQpDvQF9C+B53myZtM1Oz76BvBet17mLs
 ny8xIdvv6/rDH6ISFElF1oLM1DmQ0FC/LUDGpt+Ggl1p6mnPBUtRJvaNReLPttXCDPXtY56kp
 O61jSM5AEIOBwyPxMZ9/whXAJoDufZdCdvk7RGjgilv8XDQ5pzBmEzLWg8/HQ5/dpYEd1E19O
 MjNEv8PwoBRtlGKlrZfHEGCuY4jSnCR0g3Yq9hcPJDYqjQtoKjMVgK/+eGNcwVe6EstWRnIGL
 bRjWpkfNEfE3sk1Br5IbzJbqLXkKlkHIETFgNGmWqdiHQS/1j6gp/h1AlPrjJvtLdVsFclRXY
 iBjT3bEkO3QDL3zZ27D1KEGL5ZSlr7eAjzOuycKX12A3t8O8aqLuNlqISc1vH81RRp/ej+bMP
 lnbejGOrJmCrgnvWd0sSWEXNUv5R2VPXJJXUOi5N9OF+dPw0qH9pIp4aTP2H9mTws8s9n93dx
 +J6U+hFIWj6Qyld/iDnjnlsdkwb7hbZWMxSkWsHt/t5Q9TxQdoDpXN8vQ070WQzfGJOlhJB4Y
 qXRIk43eJ7b5QKCwINO8AUG1rNnwF4VeELbwiyLHcack4JbHZ/HqVeBS3+vdMA3MulKJ6qTGY
 wrUF4m5BOOABChrmzYYHYpP/lxMNwPAdtML3R6TQupK/dOfQO7zZO/K/KWZKbj5J8QA/XKjWj
 wO+xyDL+12/m+qY7DSbzVAW4R7VUJV1Wlr3+/zky0K6X7x0HZFu5CclMWJsi3zpQb+e2n9H59
 LHQeieo/C7A4aS/h8cDmctngQwpScCHw1L8HqIXU/RYwI5Yd4igQFzINcUTgyo1xuynopoK+a
 jPTB40F+LUFCwJNyKLEzpqCjPtD2y1kylOUooVNJTzGm/CnVP5fiU0kRyv5vle8Is5pYHNeg1
 2xIJE4J6b+tPVmDFN44ky9xxPFz6j8ws1iZ/LRjZnLaULxXBDgodgg/K+vRCFMM1VChiwWrEh
 kXO7ObfaED/Onm9KxugrijyOmOxa+X+ebLLQ45JMabeoVzMjI+kkCICrdN/9T9b/QfPWaQ6CG
 1p4sf+NRAhM+gAba1DIvmLqN3r6SdpggAH90sjm68Dm94qsZAnI1MGJTPwgOikh8VezPwfWkF
 XDVvebIx3SdzvmAt4fAG8r1vjaHG942j3zWzQo7/UDGeUo5vskcp+R7hqXOw6diQRuk63DPE0
 4sKZexDXVSBeC8HsHHPsqoA4L8rjM8Hw3BzZsdRPfzSjjh+3JkoJ4rvLR3KL4vKtt6iH6YRsQ
 llsluq4WQEJks6J7RkbiwXpQMxd/DFVbDC7+t2PMUYyR9SlEprAqQhZt9dNE2nNjUaJE/DcY6
 J9pTBWMaeCVUOvg+RXK6JMK+t5epg4JxUG0mvvw4otwhbhC3YtE7Yl12Ce0+uXOXVp5AvEwPC
 R5Y3HH8MqpCw+GCFXb0Kl6hXHAk7coy2EQ3nEQLxKpUUgKi+4/w2LsxClMxp9Hx4i2Uvx+zZ1
 k8CWx4YeeUtLg5sScfRyu51YTgRumRp6Wk8hLtZH4x9AXO7mMOny2do3eKgsiVz6s6g4m1xVP
 8sgf4QhDn41RTqfsSmFQ9qUAusuIG0TMJb2TtdJJpFqCevfMNRsAdnP961mLEiqFZbScSgSBO
 e+8rZ00H2pKAZghe+GOFJYmNA85/CGjpAeF3ffUHV46AMyS7pXIOM2Jc6aDfMer5WobRBa15S
 wwhAyS+CnEBYfUdEYcY4twAzgowQQ7O36zaiPyoBply5jBWkONfjtY7qIxP2S/mBlaa3akLqQ
 32WDhcB4IEpQ3xUskUlI/oYlTEbYTicqabE+bxHkBT+PAzTGeF95T1HmyPOxN43zy1aw5xfOU
 0j6wPEtvkbiob41zPuJTP5/Yg3yij2OA9cvue3aRJkJROawNpyhSTsu0W9cbjhpXlQUfelGrK
 xQZdkQBdWv78K6yeYQ8aCO5uoV9cOoU88DEqQwuRi3C6DxRC4Z2aH0dARygpROIL6EGsKFXkP
 XwZw6M8QK0HFyKmXY+LsY0uLUnfxevTzb2Al/sqrgkyGfV4WJXpq2H5UCHHfCy8EV8FvrgWvG
 qOyj2B88KvePqaVerITr4Ac6IzkCpMALkPO+0nlbwouYfA/23k1SeQjOYErOoam2q3SEhNX7n
 NhCLxkG4I2v9ocdo1YjUHExb+qz66ia3tHnbnvVeQN9NA/qFj2wom1v15LU7+/lQF9EEGzOg4
 U4XznAycwrYJUuR8XalDpL7upAf2Th4HlNfl3d8CMW+5VUoDsXv8lZljezNCjhDrC1nPdvlfb
 6py7lI1yLIDLKfr0ldAd7BuvbGDXgxbvhLgVKUJe9IsUEE4hcWTDX9yLejD+jjO3fchlo1CPp
 fVwwJEUSm6BMkkQ5vpAnYQGWCAmFu5sYyra1wuZKiL/dkIW5b0N6l29YeLoRN+lYUMa4AZFBm
 dEuIVCnBJ+SlLVC2hTD4rPLI33oXt1ZoHqny28vN2xHEG7sY3L+BVN5uGDdKCE+kch/QU+fwT
 ZVITP9IHl9Zu+5OCMOY1ROAVaRXL2gNf4Xah6tVPtXk1GBW2UjcpWEpyLzP9JbuADXQmH1hYw
 mJmJ3zN4fx+fa01cewChL5ojVK4n414sbu0V+JVwQOrbNdo5sW/3X8XpvKFwH9vFpBQx8FPbv
 2lRifxL5UnxmMG5IJdctBU2gkt99hgLhbRITDCFkvMRBHy2YzPYwFWLI20xrFYaVlx8K4qF2K
 MemJJycgLoKl4THeOf6/rplKxpQtDhTWKYSP0wsAapJNDL4M9c3q6j0QPYnijti2BYzw1kxxn
 iZpYrguurP95VtC3lo6CsfvH8HlDfEO0vfmMt/J5SHqY3IclwppKwHiW51rxcad5pxOL1QXF8
 haXqGNuKYc8bD+AswtU/1NmislKDktqcKlnVbX64q4ep63eI43xwK9gyhZZNV+QrmOOiqbgMF
 bTeFE44+IKKGjzHMUPRUiXuURsjas3iGH/n/g6jHMiQracoPU2NyJGvXkH8lpRqokBsH3itES
 6GzgrB6ACiYfwzbgvPqrPY0821jJc/+DM/TghAxfKi2vYEXBQqTpXiisCkHOG97vr8gG5VjXm
 +PYJy6lHGy9wbFpD+RHTnRHKoPkoahXoDT062j

Am Donnerstag, dem 19.02.2026 um 19:58 -0500 schrieb Steven Rostedt:
> On Fri, 20 Feb 2026 00:10:41 +0100
> Bert Karwatzki <spasswolf@web.de> wrote:
>=20
> > These seem to be the same type of messages that commit
> > 9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PR=
EEMPT_RT")
> > is supposed to fix.
> > When I compile a kernel with 9311e6c29b34 as HEAD I do not get these m=
essages, so
> > I guess I have to do another bisection here.
>=20
> Can you add to the kernel command line:
>=20
>  trace_event=3Dsched_switch traceoff_after_boot
>=20
> And then look at /sys/kernel/tracing/trace
>=20
> It will enable sched_switch event and the traceoff_after_boot will
> disable tracing right before running init. That way you can see what is
> running during boot that is taking the 90 seconds.
>=20
> -- Steve

I think there's a misunderstanding here, the 90s delay happens on shutdown=
, i.e.
when using either reboot or shutdown. I've changed the subject accordingly=
.

Bert Karwatzki

